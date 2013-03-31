# -*- coding: utf-8 -*-
#
# Copyright 2012-2013 Ease Software, Inc.
# All Rights Reserved
#

# Presents a GetSrcFile
class SrcFilePresenter < ApplicationPresenter
  presents :get_src_file
  delegate :error, :path, :version, :release, :lines, to: :get_src_file

  # Creates the page title string for the page
  def page_title
    "#{release} #{path} #{version}"
  end

  # Creates the HTML for the help text.
  def help_text
    build_html do
      p <<-'P1'
      Not much help needed here.  This is just the source file that
      was pulled from CMVC.
      P1
    end
  end
  
  # Creates a pre tag containing the lines from the CMVC defect or
  # calls error_block if there was an error retrieving the text.
  def show_file
    if error.blank?
      build_html do
        pre.src_file do
          lines
        end
      end
    else
      error_block(error)
    end
  end
end
