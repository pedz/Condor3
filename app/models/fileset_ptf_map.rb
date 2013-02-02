# -*- coding: utf-8 -*-
#
# Copyright 2012-2013 Ease Software, Inc.
# All Rights Reserved
#

# A single Ptf can ship multiple filesets.  There are rare instances
# where the same fileset is shipped in more than one Ptf.  This is a
# join table representing that many to many relationship.
class FilesetPtfMap < ActiveRecord::Base
  ##
  # :attr: id
  # The Integer primary key for the table.

  ##
  # :attr: fileset_id
  # The id of the Fileset this join record is associated with.
  
  ##
  # :attr: ptf_id
  # The id of the Ptf this join record is associated with.

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
  # A belong_to association with the Fileset this join record is
  # associated with.
  belongs_to :fileset

  ##
  # :attr: ptf
  # A belongs_to association with the Ptf this join record is
  # associated with.
  belongs_to :ptf
end
