# -*- coding: utf-8 -*-
#
# Copyright 2012 Ease Software, Inc.
# All Rights Reserved
#

# This model represents a fileset such as bos.mp64 5.3.2.1 that is
# shipped with AIX.  A fileset is an lpp plus a vrmf.
class Fileset < ActiveRecord::Base
  ##
  # :attr: id
  # The Integer primary key for the table.

  ##
  # :attr: lpp_id
  # The id from the lpps table that specifies the lpp that this
  # fileset is associated with.
  
  ##
  # :attr: vrmf
  # The vrmf (version, release, modification, fix) level of the
  # fileset.
  
  ##
  # :attr: created_at
  # Rails normal created_at timestamp that is when the db record was
  # created.

  ##
  # :attr: updated_at
  # Rails normal updated_at timestamp.  Each time the db record is
  # saved, this gets updated.

  ##
  # :attr: lpp
  # A belongs_to assoication to the Lpp that this fileset is
  # associated with.
  belongs_to :lpp

  ##
  # :attr: fileset_ptf_maps
  # A has_many association to FilesetPtfMap
  has_many   :fileset_ptf_maps

  ##
  # :attr: service_pack_fileset_map
  # A has_many association to ServicePackFilesetMap
  has_many   :service_pack_fileset_maps

  ##
  # :attr: package_fileset_maps
  # A has_many association to PackageFilesetMap
  has_many   :package_fileset_maps

  ##
  # :attr: fileset_aix_file_maps
  # A has_many association to FilesetAixFileMap
  has_many   :fileset_aix_file_maps

  ##
  # :attr: ptfapardefs
  # A has_many association to ptfapardef
  has_many   :ptfapardefs

  ##
  # :attr: upd_pc_views
  # A has_many association to UpdPcView
  has_many   :upd_pc_views

  # Secondary Relationships
  ##
  # :attr: ptfs
  # A has_many to Ptf via FilesetPtfMap
  has_many :ptfs,          :through => :fileset_ptf_maps

  ##
  # :attr: service_packs
  # A has_many association to ServicePack via ServicePackFilesetMap
  has_many :service_packs, :through => :service_pack_fileset_map

  ##
  # :attr: packages
  # A has_many assoication to Packaage via PackageFilesetMap
  has_many :packages,      :through => :package_fileset_maps

  ##
  # :attr: aix_files
  # A has_many association to AixFile via FilesetAixFileMap
  has_many :aix_files,     :through => :fileset_aix_file_maps

  # The <=> operator for filesets which sorts by the lpp's names first
  # and then the vrmf.
  def <=>(other)
    if (temp = self.lpp <=> other.lpp) == 0
      self.vrmf <=> other.vrmf
    else
      temp
    end
  end

  # Returns the image paths for the packages associated with this
  # fileset.
  def image_paths
    self.packages.map { |m| m.image_paths }.flatten
  end
end
