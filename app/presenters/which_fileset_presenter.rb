# -*- coding: utf-8 -*-
#
# Copyright 2012-2013 Ease Software, Inc.
# All Rights Reserved
#

# which fileset presenter
class WhichFilesetPresenter < ApplicationPresenter
  presents :which_fileset
  delegate :path, :paths, to: :which_fileset

  def page_title
    "which fileset for #{path}"
  end

  def help_text
    build_html do
      p do
        "Lots more help needed here"
      end
    end
  end

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