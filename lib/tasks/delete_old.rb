# -*- coding: utf-8 -*-
#
# Copyright 2007-2011 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#
#!/usr/bin/env ruby

# Deletes the old NEEDS_APAR entries when an APAR has been created.
# Note that this should be done when the new APAR is created.  This
# script is a stop gap until a better solution can be implemented.

needs_apar = Apar.find_by_name('NEEDS_APAR')
advs = needs_apar.apar_defect_version_maps
advs.each do |adv|
  temp = AparDefectVersionMap.find(:all,
                                    :conditions => "defect_id = #{adv.defect_id} AND version_id = #{adv.version_id} AND apar_id != #{adv.apar_id}")
  if temp.length > 0
    adv.destroy
    temp.each do |t|
      puts "#{temp.length} #{adv.defect.name} #{adv.version.name} #{t.apar.name}"
    end
  end
end
