# -*- coding: utf-8 -*-
#
# Copyright 2012 Ease Software, Inc.
# All Rights Reserved
#

# A model that represents a view of the database used mostly for
# querying the database by hand.
class ShippedFile < ActiveRecord::Base
  ##
  # :attr: aix_file
  # The path attribute from the AixFile

  ##
  # :attr: aix_file_id
  # The id attribute from the AixFile

  ##
  # :attr: fileset_id
  # The id attribute from the Fileset

  ##
  # :attr: image_path
  # The path attribute frmo the ImagePath

  ##
  # :attr: image_path_id
  # The id attribute frmo the ImagePath

  ##
  # :attr: lpp
  # The name attribute from the Lpp

  ##
  # :attr: lpp_id
  # The id attribute from the Lpp

  ##
  # :attr: package
  # The name attribute from the Package

  ##
  # :attr: package_id
  # The id attribute from the Package

  ##
  # :attr: service_pack
  # The name attribute from the ServicePack

  ##
  # :attr: service_pack_id
  # The id attribute from the ServicePack

  ##
  # :attr: aix_file_sha1
  # The sha1 attribute from the AixFile

  ##
  # :attr: vrmf
  # The vrmf attribute from the Fileset
end
