# -*- coding: utf-8 -*-
#
# Copyright 2007-2011 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#
#!/usr/bin/env ruby

# task file to import pc view output.

# I gave up trying to use runner magically.  To run these scripts just
# type out the whole command like:
# script/runner lib/tasks/import_pc_views.rb file1 file2 ...

# The default select of pc_view is no longer used.  Now this select is
# used:
# -select id,defect,product,apar,version,cq_defect_name
#
# The first will be the pc_id which may come in handy later (like
# updates)

GOOD_PRODUCT = Regexp.new("aix")
GOOD_VERSION = Regexp.new("^(5[234].|[67]..)$")

# reload_libs loads all the files */**/*.rb which includes this
# file.  The 'if' statement below prevents this file from causing an
# exception during the reload processing.
if ARGV[0]
  begin
    Rails.logger.level = ActiveSupport::BufferedLogger::WARN
    
    File.open(ARGV[0]) do |file|
      Apar.transaction do
	file.each_line do |line|
	  line.chomp!
	  pc_id, defect, product, apar, version, cq_defect = line.split('|')

	  # restrict to only AIX for now.
	  next unless GOOD_PRODUCT.match(product)

	  # restrict to 5.2 and later versions
	  next unless GOOD_VERSION.match(version)

	  # cq_defect was added after the fact so we put the cq_defect
	  # into the defect if we need to and check it to make sure it
	  # is correct otherwise.
	  defect = Defect.find_or_create_by_name defect
	  unless cq_defect.nil? or cq_defect == "null"
	    if defect.cq_defect == "NONE"
	      defect.update_attributes(:cq_defect => cq_defect)
	    elsif defect.cq_defect != cq_defect
	      throw "defect #{defect.name} as cq_defect of #{defect.cq_defect} in db but #{cq_defect} in rp2"
	    end
	  end
	  apar = Apar.find_or_create_by_name apar
	  version = Version.find_or_create_by_name version
	  
	  adv_hash = {
	    :apar_id => apar.id,
	    :defect_id => defect.id,
	    :version_id => version.id
	  }
	  adv = AparDefectVersionMap.find(:first, :conditions => adv_hash)
	  unless adv
	    puts adv_hash
	    adv = AparDefectVersionMap.create(adv_hash)
	  end

	  # pc_id was added later so we update it if it is null to start
	  # with and check it to be sure it is the same otherwise.
	  if adv.pc_id.nil? || adv.pc_id == -1
	    adv.update_attributes(:pc_id => pc_id)
	  elsif adv.pc_id != pc_id.to_i
	    throw "adv for apar/defect/version #{defect.name}/#{apar.name}/#{version.name} has pc_id of #{adv.pc_id} in db but #{pc_id} in rp2"
	  end
	end
      end
    end
  rescue => e
    puts e.message
    puts e.backtrace
    exit 1
  end
end
