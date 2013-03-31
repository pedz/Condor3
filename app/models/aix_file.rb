# -*- coding: utf-8 -*-
#
# Copyright 2012-2013 Ease Software, Inc.
# All Rights Reserved
#

# This model represents a file that is shipped in AIX.
class AixFile < ActiveRecord::Base
  ##
  # :attr: id
  # The Integer primary key for the table.

  ##
  # :attr: path
  # The full path of the shipped file.

  ##
  # :attr: sha1
  # The sha1 hash key for the file.

  ##
  # :attr: created_at
  # Rails normal created_at timestamp that is when the db record was
  # created.

  ##
  # :attr: updated_at
  # Rails normal updated_at timestamp.  Each time the db record is
  # saved, this gets updated.

  ##
  # :attr: fileset_aix_file_maps
  # A has_many association to FilesetAixFileMap
  has_many :fileset_aix_file_maps

  ##
  # :attr: filesets
  # A has_many association to Fileset via the fileset_aix_file_maps
  # association
  has_many :filesets, through: :fileset_aix_file_maps

  # returns self.path <=> other.path
  def <=>(other)
    path <=> other.path
  end
end
