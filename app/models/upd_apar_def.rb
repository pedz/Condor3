# -*- coding: utf-8 -*-
#
# Copyright 2007-2011 Ease Software, Inc. and Perry Smith
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
  # :apar: lpp
  # name from Lpp

  ##
  # :apar: lpp_id
  # id from Lpp

  ##
  # :apar: lpp_base
  # name from LppBase

  ##
  # :apar: lpp_base_id
  # id from LppBase

  ##
  # :apar: ptf
  # name from Ptf

  ##
  # :apar: ptf_id
  # id from Ptf

  ##
  # :apar: service_pack
  # name from ServicePack

  ##
  # :apar: service_pack_id
  # id from ServicePack

  ##
  # :apar: version
  # name from Version

  ##
  # :apar: version_id
  # id from Version

  ##
  # :apar: vrmf
  # vrmf from Fileset
end
