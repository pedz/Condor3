# -*- coding: utf-8 -*-
#
# Copyright 2012-2013 Ease Software, Inc.
# All Rights Reserved
#

# swinfo presenter.  Presents a GetSwinfos.
class SwinfoPresenter < ApplicationPresenter
  presents :swinfo
  delegate :item, :errors, :upd_apar_defs, to: :swinfo

  # Returns the string page title
  def page_title
    "swinfo for #{item}"
  end

  # Returns the HTML for the help content.
  def help_text
    t = <<-P1
<p>

  This is a table of "swinfo" entries for a particular item.  The help
  on the welcome page describes various items that can be searched
  for such as defect, APAR, PTF, etc.

</p><p>

  The column names in the header can be clicked to sort the table.
  There are three columns that are sorted.  The first column has the
  darkest up or down arrow while the third column has the lightest up
  or down arrow.  For example, the default is to sort by the defect
  first, then by the APAR, and finally by the PTF.

</p><p>

  The page implements an "endless page" user interface where only the
  first 1000 rows are rendered.  When the bottom of the page is
  scrolled to, then the next 1000 rows are fetched and appended to the
  original.  Remember this if you ever search using the in browser, in
  page search because you may not be searching on the complete list of
  items that matched.

</p><p>

  The entries under the Defect, APAR, PTF, VRMF, and Service Pack
  columns are links to do a "swinfo" search for that particular item.

</p><p>

  The little triangles on the right edge of many items presents a menu
  of available actions when clicked.  For example, if one of the
  triangles by a defect is clicked, the user is presented with the
  ability to retrieve the CMVC defect, the changes the defect resulted
  in, the APAR draft (if any) associated with the defect.  Each of
  these menus also has a "Select text" option to select the text.  The
  text is <b>not</b> copied to the clipboard.  To do that requires
  flash which I did not want to depend upon.  Part of the goal is to
  make the UI tablet friendly and flash is definitely not tablet
  friendly.

</p>
P1
    return t.html_safe
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
      if upd_apar_defs.length == 0
        div.upd_apar_defs do
          span "Did not find any items matching request"
        end
      else
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
