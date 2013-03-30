# -*- coding: utf-8 -*-
#
# Copyright 2012-2013 Ease Software, Inc.
# All Rights Reserved
#

# Presents a GetSha1s
class Sha1Presenter < ApplicationPresenter
  presents :sha1
  delegate :shipped_files, to: :sha1

  # Returns the string for the title of the page.
  def page_title
    "SHA1 for #{sha1.sha1}"
  end

  # Returns the HTML for the help text for the page.
  def help_text
    build_html do
      p "Lots more help needed here"
    end
  end

  # Returns a table showing the matching SHA1 entries or a div showing
  # "No matches" if none were found.
  def show_table
    build_html do
      if shipped_files.length == 0
        div.sha1s do
          span "Did not find any files matching SHA1 of #{sha1.sha1}"
        end
      else
        table.sha1s do
          thead do
            tr do
              th "aix file"
              th "image path"
              th "lpp"
              th "package"
              th "service pack"
              th "aix file sha1"
              th "vrmf"
            end
          end
          tbody do
            shipped_files.each do |shipped_file|
              tr do
                td shipped_file.aix_file
                td shipped_file.image_path
                td shipped_file.lpp
                td shipped_file.package
                td shipped_file.service_pack
                td shipped_file.aix_file_sha1
                td shipped_file.vrmf
              end
            end
          end
        end
      end
    end
  end
end
