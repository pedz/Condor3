# -*- coding: utf-8 -*-
#
# Copyright 2012-2013 Ease Software, Inc.
# All Rights Reserved
#

# cmvc defect presenter
class CmvcDefectPresenter < ApplicationPresenter
  presents :get_cmvc_defect
  delegate :type, :defect_name, :error, :lines, to: :get_cmvc_defect

  def page_title
    "CMVC #{type} #{defect_name}"
  end

  def help_text
    build_html do
      p "Lots more help needed here"
    end
  end
  
  def show_defect
    if error.blank?
      build_html do
        pre.cmvc_defect do
          lines
        end
      end
    else
      error_block(error)
    end
  end
end
