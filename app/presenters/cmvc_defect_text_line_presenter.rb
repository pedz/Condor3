# -*- coding: utf-8 -*-
#
# Copyright 2012-2013 Ease Software, Inc.
# All Rights Reserved
#

# Presents a GetCmvcDefect
class CmvcDefectTextLinePresenter < ApplicationPresenter
  presents :get_cmvc_defect
  delegate :type, :defect_name, :error, :lines, to: :get_cmvc_defect

  # Creates the page title string for the page
  def page_title
    "CMVC #{type} #{defect_name}"
  end

  # Creates the HTML for the help text.
  def help_text
    build_html do
      p <<-P1
         Not much needed here.
        P1
    end
  end
  
  # Creates a pre tag containing the lines from the CMVC defect or
  # calls error_block if there was an error retrieving the text.
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
