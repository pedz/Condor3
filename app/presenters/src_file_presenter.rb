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
          lines_with_line_numbers
        end
      end
    else
      error_block(error)
    end
  end

  private

  # This isn't cheap :-(
  def lines_with_line_numbers
    temp_lines = lines.split("\n")
    length = temp_lines.length
    digits = 1
    while (length > 0)
      length /= 10
      digits += 1
    end

    lineno = 0
    fmt = "%#{digits}d|%s"
    temp_lines.map do |line|
      lineno += 1
      fmt % [lineno, line]
    end.join("\n")
  end
end
