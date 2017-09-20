# -*- coding: utf-8 -*-
#
# Copyright 2007-2011 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#

# This is a two pass process.
#
# Pass 1 - We run through for each ImagePath, get the Package
# associated with it, and then for each Fileset associated with the
# Package we add a ServicePackFilesetMap.
#
# Pass 2 - For each ServicePack, we sort the Fileset associated with
# the ServicePack.  If we find, for example, bos.mp64 6.1.6.3 and
# bos.mp64 6.1.6.15 associated with the ServicePack, this is because
# the directory with the PTFs had both of those PTFs in the
# directory. I've discovered that this happens.  When all of those are
# installed, the level will be bos.mp64 at 6.1.6.15 so we delete the
# association to bos.mp64 6.1.6.3.
#
# The two passes allows for a Fileset to be associated with more than
# one ServicePack.  This happens often with filesets that do not
# change very often.  But it eliminates the confusion caused when the
# same directory full of PTFs contains multiple versions of the same
# fileset.

# The select needs to use regular expressions so I'm just going to do
# it in Ruby code along with the sort
def process_images(pat, sp_name)
  sp = ServicePack.find_or_create_by_name(sp_name)
  images = ImagePath.find(:all, :conditions => "path like '#{pat}'")
  length = images.length
  images.each_with_index do |image, index|
    # puts "processing image #{index} of #{length}"
    image.package.filesets.each do |fileset|
      ServicePackFilesetMap.find_or_create_by_service_pack_id_and_fileset_id(sp.id, fileset.id)
    end
  end
end

def process_service_packs(sp_name)
  l = lambda { 0 }
  puts "processing service pack #{sp_name}"
  sp = ServicePack.find_by_name(sp_name)
  filesets = sp.filesets
  # puts "#{filesets.length} to be processed"
  last_lpp_name = ""
  unshipped = ServicePack.find_or_create_by_name('unshipped')
  filesets.sort do |a, b|
    if a.lpp.name != b.lpp.name
      a.lpp.name <=> b.lpp.name
    else
      # Now, compare the silly vmrf's (which is hard and expensive)
      av = a.vrmf.split('.').collect { |i| i.to_i }
      bv = b.vrmf.split('.').collect { |i| i.to_i }
      (0 .. 3).map { |i| bv[i] <=> av[i] }.detect(l) { |c| c != 0 }
    end
  end.each do |fileset|
    # puts "#{fileset.lpp.name} #{fileset.vrmf}"
    if last_lpp_name == fileset.lpp.name
      # puts "#{fileset.lpp.name} #{fileset.vrmf} should be deleted"
      ServicePackFilesetMap.find_by_service_pack_id_and_fileset_id(sp.id, fileset.id).destroy
      ServicePackFilesetMap.find_or_create_by_service_pack_id_and_fileset_id(unshipped.id, fileset.id)
    else
      last_lpp_name = fileset.lpp.name
    end
  end
end

if $0 == __FILE__ || $0 == 'script/runner'
  if ARGV.length != 2
    $stderr.write "Usage: $0 <pattern> <sp_name>\n"
    exit 1                    # exit status
  end
  puts "#{ARGV[0]} #{ARGV[1]}"
  begin
    process_images(ARGV[0], ARGV[1])
    process_service_packs(ARGV[1])
  rescue Exception => e
    puts "ERROR"
    puts e.message
    puts e.backtrace.join("\n")
    exit 4                    # exit status
  end
end
