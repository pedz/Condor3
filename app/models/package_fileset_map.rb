# -*- coding: utf-8 -*-
#
# Copyright 2012 Ease Software, Inc.
# All Rights Reserved
#

# A join table between Package and Fileset.  A Package can deliver
# more than one Fileset.  Also, the same Fileset, especially one that
# rarely changes, can be delivered in several Packages.
class PackageFilesetMap < ActiveRecord::Base
  ##
  # :attr: id
  # The Integer primary key for the table.

  ##
  # :attr: package_id
  # The id of the Package
  
  ##
  # :attr: fileset_id
  # The id of the Fileset
  
  ##
  # :attr: created_at
  # Rails normal created_at timestamp that is when the db record was
  # created.

  ##
  # :attr: updated_at
  # Rails normal updated_at timestamp.  Each time the db record is
  # saved, this gets updated.

  ##
  # :attr: package
  # A belongs_to association to the Package
  belongs_to :package

  ##
  # :attr: fileset
  # A belongs_to association to the Fileset
  belongs_to :fileset
end
