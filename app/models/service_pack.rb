# -*- coding: utf-8 -*-
#
# Copyright 2012-2013 Ease Software, Inc.
# All Rights Reserved
#

# A model that represents a service pack or update.  For AIX, (in 2012
# at least) they are called service packs such as 6.1 TL05 SP04.  For
# VIOS, they tend to be called updates.
class ServicePack < ActiveRecord::Base
  ##
  # :attr: id
  # The Integer primary key for the table.

  ##
  # :attr: name
  # The name of the ServicePack e.g. "6100-06-05" or "VIOS 2.2.1.4"

  ##
  # :attr: created_at
  # Rails normal created_at timestamp that is when the db record was
  # created.

  ##
  # :attr: updated_at
  # Rails normal updated_at timestamp.  Each time the db record is
  # saved, this gets updated.

  ##
  # :attr: service_pack_fileset_maps
  # A has_many association of ServicePackFilesetMap records
  has_many :service_pack_fileset_maps

  # Secondary Relationships
  ##
  # :attr: filesets
  # A has_many association of Fileset records via service_pack_fileset_maps
  has_many :filesets, through: :service_pack_fileset_maps
end
