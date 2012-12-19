# -*- coding: utf-8 -*-
#
# Copyright 2012 Ease Software, Inc.
# All Rights Reserved
#

# This model is a view in the database.  See AddUpdAparDefsView
# migration for details.
class UpdAparDef < ActiveRecord::Base
  ##
  # :attr: abstract
  # abstract from Apar

  ##
  # :attr: apar
  # name from Apar

  ##
  # :attr: apar_id
  # id from Apar

  ##
  # :attr: build_name
  # bc_name from UpdPcView
  
  ##
  # :attr: cq_defect
  # cq_defect from Defect

  ##
  # :attr: defect
  # name from Defect

  ##
  # :attr: defect_id
  # id from Defect

  ##
  # :attr: fileset_id
  # id from Fileset

  ##
  # :attr: lpp
  # name from Lpp

  ##
  # :attr: lpp_id
  # id from Lpp

  ##
  # :attr: lpp_base
  # name from LppBase

  ##
  # :attr: lpp_base_id
  # id from LppBase

  ##
  # :attr: ptf
  # name from Ptf

  ##
  # :attr: ptf_id
  # id from Ptf

  ##
  # :attr: service_pack
  # name from ServicePack

  ##
  # :attr: service_pack_id
  # id from ServicePack

  ##
  # :attr: version
  # name from Version

  ##
  # :attr: version_id
  # id from Version

  ##
  # :attr: vrmf
  # vrmf from Fileset
end
