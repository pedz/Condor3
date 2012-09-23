# -*- coding: utf-8 -*-
#
# Copyright 2012 Ease Software, Inc.
# All Rights Reserved
#

# A join table between ServicePack records and Fileset records.  A
# Fileset can be in more than one ServcePack and, likewise, a
# ServicePack ships more than one Fileset.  This many to many
# relationship is represented by this model.
class ServicePackFilesetMap < ActiveRecord::Base
  ##
  # :attr: id
  # The Integer primary key for the table.

  ##
  # :attr: service_pack_id
  # The id attribute of the associated ServicePack

  ##
  # :attr: fileset_id
  # The id attribute of the associated Fileset

  ##
  # :attr: created_at
  # Rails normal created_at timestamp that is when the db record was
  # created.

  ##
  # :attr: updated_at
  # Rails normal updated_at timestamp.  Each time the db record is
  # saved, this gets updated.

  ##
  # :attr: service_pack
  # A belongs_to association of ServicePack records.
  belongs_to :service_pack

  ##
  # :attr: fileset
  # A belongs_to association of Fileset records
  belongs_to :fileset
end
