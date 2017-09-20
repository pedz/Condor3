#!/usr/bin/env ruby
# -*- coding: binary -*-
#
# Copyright 2012 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#

# This is stolen from scan_mounts but walks through the GSA build
# trees instead of the downloaded shipped install and update images.

# Note that this script should be run as root with a command like:
# script/runner lib/tasks/scan_mounts.rb

# It depends upon data being a symbolic link to the shared/data
# directory which should be set up via the capistrano deploy
# sequence.

# The first step is to mount each exported file system that we are
# interested in.  We mount them in data/mounts.  We mount them only as
# we need them.

require File.dirname(__FILE__) + "/toc-parser"

ROOT = Pathname.new(File.dirname(__FILE__) + "/../..").realpath
DATA = (ROOT + "data").realpath
TEMP_DIR = Pathname.new("/home/condor/work/tmp")
TEMP2_DIR = Pathname.new("/home/condor/work/tmp")
LOG_PATH = Pathname.new("log/scan_gsa.log")
DEBUG = false

# main_loop of the scan_mounts script runs thru the matches for
# GSA_PATTERN.  For each item in the list, it creates a mount point if
# one does not already exists and mounts the file system if it is not
# already mounted.  Then it does a find on the new mounted file
# system.  For each flat file, process_file is called.
def main_loop
  puts GSA_PATTERN
  Pathname.glob(GSA_PATTERN.to_s, 0).sort do |a, b|
    a.to_s.sub(/Gold/, '-00') <=> b.to_s.sub(/Gold/, '-00')
  end.each do |gsa_dir|
    STDERR.puts "\nSearching #{gsa_dir}\n"
    STDERR.flush
    gsa_dir.cleanpath.find do |image_path|
      STDERR.puts "\nReviewing #{image_path}"
      STDERR.flush
      next unless image_path.file?    # skip all but flat files
      process_file(image_path)
    end
  end
end

# Process file first sees if this image_path is already in image_paths.  If
# it is, it assumes that things have not changed and it is skipped.
# It then creates an ImageFile and passes the processing off to it.
def process_file(image_path)
  relative_path = image_path.relative_path_from(GSA_BASE)
  STDERR.puts "relative path = #{relative_path}"
  STDERR.flush
  return if ImagePath.find_by_path(relative_path.to_s)
  image_file = ImageFile.new(ImagePath.new(:path => relative_path.to_s), image_path)
  image_file.process
end

# ImageFile is a class to contain the work of processing an image
# file.
class ImageFile
  def initialize(image, full_path)
    @image, @full_path = image, full_path
  end
  
  BACKUP_MAGIC = "\x09\x00\x6b\xea".force_encoding(:binary).freeze
  
  # reads the first four bytes to see if it is a backup file ( a
  # possible install / update image.  If it is not a backup file, then
  # a new image_paths is created with the package id set to the
  # 'not-a-backup' package and then returns.  If all these tests pass,
  # process_package is called.
  def process
    begin
      STDERR.puts "Start processing #{@full_path}"
      STDERR.flush
      # We can get a permission denied here so we catch the error, log
      # it and move on.
      @full_path.open do |file|
        magic = file.read(4)
        unless magic == BACKUP_MAGIC
          # Flat file that is not a backup image
          image_is('not-a-backup')
          return
        end
      end
    rescue Exception => e
      STDERR.puts "ERROR -- permission error"
      STDERR.puts e.message
      STDERR.flush
      image_is('permission-error')
      return
    end
    
    
    # calcualte the SHA1
    STDERR.puts "Calculating SHA1 for #{@full_path}"
    STDERR.flush
    @sha1 = Digest::SHA1.file(@full_path).hexdigest
    
    # We assume that two files with the same SHA1 are the same file
    # in a different location.
    if package = Package.find_by_sha1(@sha1)
      @image.package = package
      @image.save
      return
    end
    
    process_package
  end
  
  private
  
  # At this point, we know that @full_path is a backup file and we will
  # restore its contents in a temp directory and then try to understand
  # it.  This should return true if no errors happened and false if we
  # hit an error that is so bad we need to re-process the file somehow.
  INVENTORY_REGEXP = /^(.*)\.inventory$/.freeze
  COLON_REGEXP = /^(.*):.*$/.freeze
  
  def process_package
    begin
      return unless restore_package
      return unless chmod_package(true)

      # The old "populate" script would change the permissions on all the
      # directories in the exploided package be 777.  It would then add
      # write permissions to everything.  I can't recall why that was done
      # but as I recall, there was a reason for it.  Perhaps it was so we
      # could delete it when we were done.  I'm not going to do that yet.
      
      # We now need to understand the lpp_name file if one exists.  If one
      # does not, then we just exit.
      lpp_name = TEMP_DIR + "lpp_name"
      unless lpp_name.file?
        image_is('not-a-backup')
        return
      end

      lpp_name.open do |file|
        # We assume each image path has only one package.  This may
        # not be dictated anywhere so we are going to check and make
        # sure it is true.
        first_time = true
        Toc::Parser.parse(file).each do |parsed_package|
          unless first_time
            STDERR.puts "ERROR: #{@full_path} has more than one package in its lpp_name"
            STDERR.flush
            image_is('more-than-one-package')
            return
          end
          @package = new_package(parsed_package.name)
          @image.package = @package
          fileset_hash = { }
          parsed_package.filesets.each do |parsed_fileset|
            fs = fileset(parsed_fileset)
            if fileset_hash.has_key?(fs.lpp.name)
              STDERR.puts "ERROR: Image at #{@full_path} has two filesets with the " +
                "same lpp name of #{fs.lpp.ame}"
              STDERR.flush
              image_is('two-filesets')
              return
            end
            fileset_hash[fs.lpp.name] = fs
            @package.filesets << fs
          end

          # We find all of the liblpp.a files, create a directory
          # called liblpp in the same directory and then expand the
          # libllpp.a file into it.  We pull out the .inventory files
          TEMP_DIR.find do |path|
            if DEBUG
              STDERR.puts "DEBUG: path=#{path}"
              STDERR.flush
            end
            next unless path.basename.to_s == "liblpp.a"
            result = expand_liblpp(path) do |child|
              if DEBUG
                STDERR.puts "DEBUG: child=#{child}"
                STDERR.flush
              end
              next unless (match1 = INVENTORY_REGEXP.match(child.basename.to_s))
              if (fs = fileset_hash[match1[1]]).nil?
                STDERR.puts "ERROR: Image at #{@full_path} has inventory file " +
                  "for '#{match1[1]}' but was not entered in the lpp_name." +
                  " - skipping..."
                STDERR.flush
                image_is('extra-inventory-file')
                next
              end

              # child is now an inventory file that we dug out of one
              # of the liblpp.a files.  We find the lines with a colon
              # which are the full path names of the installed files.
              child.readlines.each do |line|
                if DEBUG
                  STDERR.puts "DEBUG: line=#{line}" 
                  STDERR.flush
                end
                next unless (match2 = COLON_REGEXP.match(line))
                af = aix_file(match2[1])
                if !af.new_record? &&
                    !fs.new_record? &&
                    !fs.aix_files.exists?(:id => af.id)
                  fs.aix_files << af
                end
              end
            end
            if result == false
              image_is('not-a-backup')
              return
            end
          end
        end
      end
      @image.save
    rescue Exception => e
      STDERR.puts "ERROR"
      STDERR.puts e.message
      STDERR.puts e.backtrace
      STDERR.flush
      # Try and keep going.
    ensure
      remove_temp_dir
    end
  end
  
  def aix_file(installed_path)
    local_path = TEMP_DIR + installed_path[1..-1]
    if local_path.file?
      STDERR.puts "Calculating SHA1 for #{local_path}"
      STDERR.flush
      sha1 = Digest::SHA1.file(local_path).hexdigest
    else
      sha1 = "0"
    end
    AixFile.find_or_create_by_path_and_sha1(installed_path.to_s, sha1)
  end
                
  def remove_temp_dir
    STDERR.puts "Removing temp dir"
    STDERR.flush
    if TEMP_DIR.directory?
      begin
        chmod_package(false)
        TEMP_DIR.rmtree
      rescue
        TEMP2_DIR.mkpath
        TEMP_DIR.rename(TEMP2_DIR)
      end
    end
  end
  
  def expand_liblpp(path)
    dir = path.dirname + "liblpp"
    dir.mkdir
    pid = Kernel.fork
    if pid.nil?
      Dir.chdir(dir)
      Kernel.exec("/usr/bin/ar", "x", "../liblpp.a")
    end

    Process.wait(pid)
    status = $?
    if status != 0
      STDERR.puts "ERROR: ar x of #{path} failed from #{@full_path}"
      STDERR.flush
      image_is('ar-failed')
      return false
    end

    dir.children.each do |c|
      yield c
    end
    return true
  end

  def restore_package
    STDERR.puts "Restoring #{@full_path}"
    STDERR.flush
    remove_temp_dir
    TEMP_DIR.mkpath
    pid = Kernel.fork
    
    # Child
    if pid.nil?
      Dir.chdir(TEMP_DIR.to_s)
      $stdout.reopen("/dev/null")
      $stdin.reopen("/dev/null")
      Kernel.exec("/usr/sbin/restore", "-xqf", "#{@full_path.to_s}")
    end
    
    # Parent
    Process.wait(pid)
    status = $?
    if status != 0
      STDERR.puts "ERROR: restore exited with status of #{status} from #{@full_path}"
      STDERR.flush
      image_is('restore-failed')
      return false
    end
    return true
  end

  # log is a boolean.  If called on the normal path, it is true.
  # Otherwise, it is false
  def chmod_package(log = false)
    if log
      STDERR.puts "Doing chmod"
      STDERR.flush
    end
    pid = Kernel.fork
    
    # Child
    if pid.nil?
      Dir.chdir(TEMP_DIR.to_s)
      $stdout.reopen("/dev/null")
      $stdin.reopen("/dev/null")
      Kernel.exec("/usr/bin/chmod", "-Rh", "u=rwx", ".")
    end
    
    # Parent
    Process.wait(pid)
    status = $?
    if status != 0
      if log
        STDERR.puts "ERROR: chmod exited with status of #{status}"
        STDERR.flush
        image_is('chmod-failed')
      end
      return false
    end
    return true
  end
  
  # We know that sha1 is not in the database so we know that the tuple
  # [name, sha1] will not be in the database as well.
  def new_package(package_name)
    Package.new(:name => package_name, :sha1 => @sha1)
  end
  
  def image_is(s)
    @image.package = Package.find_or_create_by_name_and_sha1(s, "0")
    @image.save
  end

  def lpp_base(lpp_name)
    LppBase.find_or_create_by_name lpp_name.sub(/\..*/, '')
  end

  def lpp(lpp_name)
    lpp_base(lpp_name).lpps.find_or_create_by_name(lpp_name)
  end

  def fileset(parsed_fileset)
    lpp(parsed_fileset.name).filesets.find_or_create_by_vrmf(parsed_fileset.vrmf)
  end

end


begin
  $stderr.reopen(LOG_PATH.to_s, "w")
  main_loop
  0
rescue Exception => e
  STDERR.puts "ERROR"
  STDERR.puts e.message
  STDERR.puts e.backtrace
  STDERR.flush
  exit(4)
end
