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
      out = table.which_filesets do
        thead do
          tr do
            th '#'
            th 'Path'
            th 'Lpp'
          end
        end
      end
      body = tbody do
        if @paths.length == 0
          tr do
            td colspan: '3' do
              "Did not find any shipped files matching #{path}"
            end
          end
        else
          index = 0
          out = ""
          out += paths.each_pair do |path, lpps|
            lpps.each do |lpp|
              tr do
                td index += 1
                td path
                td link_to(lpp, swinfo_get_path(lpp))
              end
            end
          end
          out
        end
      end
    end
  end
end
