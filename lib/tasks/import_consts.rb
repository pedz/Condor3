# -*- coding: utf-8 -*-
#
# Copyright 2007-2011 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#
#!/usr/bin/env ruby

# This script is used to import ptfapardef.constant files.

# I gave up trying to use runner magically.  To run these scripts just
# type out the whole command like:
# script/runner lib/tasks/import_consts.rb file1 file2 ...

VRMF_PAT = Regexp.new("[0-9]+.[0-9]+.[0-9]+.[0-9]+")

# reload_libs loads all the files */**/*.rb which includes this
# file.  The 'if' statement below prevents this file from causing an
# exception during the reload processing.
if ARGV[0]
  begin
    Rails.logger.level = ActiveSupport::BufferedLogger::WARN
    
    File.open(ARGV[0]) do |file|
      Apar.transaction do 
        file.each_line do |line|
          d, m = file.lineno.divmod(1000)
          puts file.lineno if m == 0
          
          line.chomp!
          fields = line.split(/\|/)
          if fields.length < 9
            STDERR.puts("line has too few fields: '#{line}'")
            next
          end
          vrmf_field = fields.length - 1
          vrmf_field -= 1 while (vrmf_field > 7 && VRMF_PAT.match(fields[vrmf_field]).nil?)
          if vrmf_field <= 7
            STDERR.puts("can not find vrmf field in line: '#{line}'")
            next
          end
          abstract = fields[7 .. (vrmf_field - 1)].join('|')

          ptf = Ptf.find_or_create_by_name fields[0]
          apar = Apar.find_or_create_by_name fields[1]
          defect = Defect.find_or_create_by_name fields[2]
          lpp_base = LppBase.find_or_create_by_name fields[3]
          lpp = lpp_base.lpps.find_or_create_by_name fields[4]
          
          family = Family.find_or_create_by_name fields[6]
          releases = fields[5].split(/ /).map do |release_name|
            next if release_name.length < 3
            version = Version.find_or_create_by_name release_name[-3,3]
            
            release_hash = {
              :name => release_name,
              :version_id => version.id
            }
            release = family.releases.find(:first, :conditions => release_hash)
            unless release
              release = family.releases.create(release_hash)
            end
            
            adv_hash = {
              :apar_id => apar.id,
              :defect_id => defect.id,
              :version_id => version.id
            }
            adv = AparDefectVersionMap.find(:first, :conditions => adv_hash)
            unless adv
              adv = AparDefectVersionMap.create(adv_hash)
            end
            
            apr_hash = {
              :apar_defect_version_map_id => adv.id,
              :ptf_id => ptf.id,
              :release_id => release.id
            }
            apr = AdvPtfReleaseMap.find(:first, :conditions => apr_hash)
            unless apr
              apr = AdvPtfReleaseMap.create(apr_hash)
            end
          end
          
          unless apar.abstract.nil?
            apar.abstract = abstract
            apar.save!
          end
          
          fileset = lpp.filesets.find_or_create_by_vrmf fields[vrmf_field]
          
          FilesetPtfMap.find_or_create_by_fileset_id_and_ptf_id(fileset.id, ptf.id)
        end
      end
    end
  rescue => e
    puts e.message
    puts e.backtrace
    exit 1
  end
end
