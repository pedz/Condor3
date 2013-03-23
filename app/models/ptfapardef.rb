# -*- coding: utf-8 -*-
#
# Copyright 2012-2013 Ease Software, Inc.
# All Rights Reserved
#

# This model is a view of the database that roughly equates to an
# entry in the ptfapardef.constant file.  For details, see the
# AddPtfAparDefsView migration that creates the view.
#
# The ptfapardef.constant files are created by the build group and
# create an association between an Apar, Defect, and Ptf along with a
# smattering of other items.  This view extends the original records
# with other associations created elsewhere.
class Ptfapardef < ActiveRecord::Base
  ##
  # :attr: abstract
  # The abstract from the Apar

  ##
  # :attr: apar
  # The name attribute from the Apar

  ##
  # :attr: apar_id
  # The id attribute from the Apar

  ##
  # :attr: defect
  # The name attribute from the Defect

  ##
  # :attr: defect_id
  # The id attribute from the Defect

  ##
  # :attr: family
  # The name attribute from the Family

  ##
  # :attr: family_id
  # The id attribute from the Family

  ##
  # :attr: fileset_id
  # The id of the Fileset

  ##
  # :attr: lpp
  # The name attribute of the Lpp

  ##
  # :attr: lpp_id
  # The id attributes of the Lpp

  ##
  # :attr: lpp_base
  # The name attribute of the LppBase

  ##
  # :attr: lpp_base_id
  # The id attribute of the LppBase

  ##
  # :attr: ptf
  # The name attribute of the Ptf

  ##
  # :attr: ptf_id
  # The id attribute of the Ptf

  ##
  # :attr: service_pack
  # The name attribute of the ServicePack

  ##
  # :attr: service_pack_id
  # The id attribute of the ServicePack

  ##
  # :attr: release
  # The name attribute of the Release

  ##
  # :attr: release_id
  # The id attribute of the Release

  ##
  # :attr: version
  # The name attribute of the Version

  ##
  # :attr: version_id
  # The id attribute of the Version

  ##
  # :attr: vrmf
  # The vrmf attribute of the Fileset
end
