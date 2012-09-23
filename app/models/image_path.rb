# -*- coding: utf-8 -*-
#
# Copyright 2012 Ease Software, Inc.
# All Rights Reserved
#

# Using scripts, GSA and other repositories of built ptf images are
# scanned and process.  This record is the path to the ptf image.  An
# image path contains precisely one package.
class ImagePath < ActiveRecord::Base
  ##
  # :attr: id
  # The Integer primary key for the table.

  ##
  # :attr: path
  # The actual path to the ptf image.  Note that a significant base
  # path may be lopped off.

  ##
  # :attr: package_id
  # The id of the Package the image contained.

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
  # A belongs_to association to the Package the ImagePath contains.
  belongs_to :package

  # returns path <=> other.path
  def <=>(other)
    path <=> other.path
  end
end
