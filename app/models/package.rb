# -*- coding: utf-8 -*-
#
# Copyright 2012-2013 Ease Software, Inc.
# All Rights Reserved
#

# A model for a "package".  A package is what a single ImagePath
# points to and contains at least one but sometimes multiple
# Filesets.  Since the Package to Fileset relationship is many to
# many, the PackageFilesetMap model is used as a join table.
class Package < ActiveRecord::Base
  ##
  # :attr: id
  # The Integer primary key for the table.

  ##
  # :attr: name
  # The name of the package.  This is found in the bff image on the
  # first line, the fourth item.  The first line of the lpp_name file
  # will be something like:
  #
  # U843218.bff 4 R S bos.iocp {
  #
  # In this case, bos.iocp is the package name.
  
  ##
  # :attr: sha1
  # The SHA1 hash value for the package.  For example, ImagePath might
  # be /down/this/path/package.bff.  The SHA1 is computed because that
  # same file might also be /down/this/other/path/over/here.bff.  The
  # SHA1 allows the two to be identified as the same.

  ##
  # :attr: created_at
  # Rails normal created_at timestamp that is when the db record was
  # created.

  ##
  # :attr: updated_at
  # Rails normal updated_at timestamp.  Each time the db record is
  # saved, this gets updated.

  ##
  # :attr: image_paths
  # A has_many association to ImagePath where this Package has been
  # found.  See also sha1
  has_many :image_paths

  ##
  # :attr: package_fileset_maps
  # A has_many assoication of PackageFilesetMap join table elemetns
  # which then point to Fileset records that this Package contains.
  has_many :package_fileset_maps

  # Secondary Relationships
  # :attr: filesets
  # A has_many association to Fileset records via PackageFilesetMap
  # join table elemtsn.
  has_many :filesets, :through => :package_fileset_maps

  # returns self.name <=> other.name
  def <=>(other)
    self.name <=> other.name
  end
end
