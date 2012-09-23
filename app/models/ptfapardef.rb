# -*- coding: utf-8 -*-
#
# Copyright 2012 Ease Software, Inc.
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

  # Assigns the controller to be used later to get the various paths.
  # I believe with the new jsrender method, all this magic is not
  # used.
  def controller=(controller)
    @controller = controller
  end

  # Returns the URL for the APAR draft for the defect.
  def apar_draft_defect_path
    if attributes.has_key? "defect"
      @controller.__send__(:apar_drafts_path, "defect", defect)
    else
      ""
    end
  end

  # Returns the URL for the APAR draft for the APAR.
  def apar_draft_apar_path
    logger.debug(self.attributes.inspect)
    if attributes.has_key? "apar"
      @controller.__send__(:apar_drafts_path, "apar", apar)
    else
      ""
    end
  end

  # Returns the URL to "show" the Defect
  def defect_path
    if attributes.has_key? "defect"
      @controller.__send__(:defect_path, defect)
    else
      ""
    end
  end

  # Returns the URL to "show" the Change introduced by the Defect.
  def changes_path
    if attributes.has_key? "defect"
      @controller.__send__(:changes_path, defect)
    else
      ""
    end
  end

  # Returns the URL to do swinfo on the Defect
  def swinfos_defect_path
    if attributes.has_key? "defect"
      swinfors_path(defect)
    else
      ""
    end
  end

  # Returns the URL to do swinfo on the Apar
  def swinfos_apar_path
    if attributes.has_key? "apar"
      swinfors_path(apar)
    else
      ""
    end
  end

  # Returns the URL to do swinfo on the Ptf
  def swinfos_ptf_path
    if attributes.has_key? "ptf"
      swinfors_path(ptf)
    else
      ""
    end
  end

  # Returns the URL to do swinfo on the Lpp
  def swinfos_lpp_path
    if attributes.has_key? "lpp"
      swinfors_path(lpp)
    else
      ""
    end
  end

  # Returns the URL to "show" the Fileset
  def fileset_path
    if attributes.has_key? "fileset_id"
      @controller.__send__(:filesets_path, fileset_id)
    else
      ""
    end
  end

  # Returns the URL to do swinfo on the Fileset
  def swinfos_fileset_path
    if attributes.has_key?("vrmf") && attributes.has_key?("lpp")
      swinfors_path("#{lpp} #{vrmf}")
    else
      ""
    end
  end

  private

  # Returns the URL to swinfo of the id passed in.
  def swinfors_path(id)
    if !id.nil?
      @controller.__send__(:swinfos_path, id)
    else
      ""
    end
  end
end
