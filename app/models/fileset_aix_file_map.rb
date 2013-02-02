# -*- coding: utf-8 -*-
#
# Copyright 2012-2013 Ease Software, Inc.
# All Rights Reserved
#

# A fileset ships a number of files but a file can also be shipped
# (unchanged) by a number of filesets.  FilesetAixFileMap is the join
# table for that many to many relationship.
class FilesetAixFileMap < ActiveRecord::Base
  ##
  # :attr: id
  # The Integer primary key for the table.

  ##
  # :attr: fileset_id
  # The id of the Fileset associated with this join.
  
  ##
  # :attr: aix_file_id
  # The id of the AixFile associated with this join.

  ##
  # :attr: created_at
  # Rails normal created_at timestamp that is when the db record was
  # created.

  ##
  # :attr: updated_at
  # Rails normal updated_at timestamp.  Each time the db record is
  # saved, this gets updated.

  ##
  # :attr: fileset
  # The Fileset associated with this join record
  belongs_to :fileset

  ##
  # :attr: aix_file
  # The AixFile associated with this join record
  belongs_to :aix_file
end
