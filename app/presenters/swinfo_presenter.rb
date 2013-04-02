# -*- coding: utf-8 -*-
#
# Copyright 2012-2013 Ease Software, Inc.
# All Rights Reserved
#

# swinfo presenter
class SwinfoPresenter < ApplicationPresenter
  presents :swinfo
  delegate :item, :errors, :upd_apar_defs, to: :swinfo

  # Returns the string page title
  def page_title
    "swinfo for #{item}"
  end

  # Returns the HTML for the help content.
  def help_text
    build_html do
      p do
        "Lots of help needed here"
      end
    end
  end

  # Shows the errors encountered if any
  def show_errors
    hash = { id: "errors" }
    hash[:style] = "display: none;" if errors.empty?
    build_html do
      section hash do
        h3 "Errors:"
        ul do
          errors.each do |msg|
            li msg
          end
        end
      end
    end
  end

  # Shows the swinfo table.  Most of the work is done via jsrender
  # (javascript) in the browser.  This effectively just renders and
  # empty table.
  def show_table
    build_html do
      table.upd_apar_defs do
        thead do
          tr do
            th '#'
            [ "Defect", "Apar", "PTF", "Abstract",
              "LPP", "VRMF", "Version", "Service Pack" ].each do |header_label|
              th class: "upd_apar_def-#{header_label.gsub(" ", "_").downcase}" do
                span class: "upd_apar_defs_header_span" do
                  text header_label
                  span class: "sort sortable" do
                  end
                end
              end
            end
          end
        end
        tbody do
          # upd_apar_defs.each_with_index { |o, i| show_upd_apar_def(o,i) }
        end
      end
    end
  end

  # Appends the json results
  def append_results
    build_html do
      script type: 'text/javascript' do
        text upd_apar_defs.to_json.html_safe
      end
    end
  end

  # Produces the output for json requests
  def to_json(options = {})
    upd_apar_defs.to_json(options)
  end
end
