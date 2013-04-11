# -*- coding: utf-8 -*-
#
# Copyright 2012-2013 Ease Software, Inc.
# All Rights Reserved
#

# which fileset presenter.  Presents a GetWhichFilesets.
class WhichFilesetPresenter < ApplicationPresenter
  presents :which_fileset
  delegate :path, :paths, to: :which_fileset

  # Returns the page title as a string
  def page_title
    "which fileset for #{path}"
  end

  # Returns the html help text
  def help_text
    build_html do
      p <<P1
This page is a simple presentation of the paths that match the file
that was searched for an the fileset that the file was shipped in.
P1
    end
  end

  # Returns the HTML to show a table of the results.
  def show_table
    build_html do
      if paths.keys.length == 0
        div.which_filesets do
          span "Did not find any shipped files matching #{path}"
        end
      else
        table.which_filesets do
          thead do
            tr do
              th '#'
              th 'Path'
              th 'Lpp'
            end
          end
          tbody do
            index = 0
            paths.each_pair do |path, lpps|
              lpps.each do |lpp|
                tr do
                  td index += 1
                  td path
                  td link_to(lpp, swinfo_get_path(lpp))
                end
              end
            end
          end
        end
      end
    end
  end
end
