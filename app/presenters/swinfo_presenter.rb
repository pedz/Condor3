class SwinfoPresenter < ApplicationPresenter
  presents :swinfo
  delegate :item, :errors, :upd_apar_defs, to: :swinfo

  def page_title
    "swinfo for #{item}"
  end

  def help_text
    build_html do
      p do
        "Lots of help needed here"
      end
    end
  end

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

  # This is not used.  It is built via javascript inside the browser.
  # def show_upd_apar_def(upd_apar_def, upd_apar_def_counter)
  #   build_html do
  #     tr.upd_apar_def do
  #       td contextmenu: "upd_apar_def_defect_menu_#{upd_apar_def_counter }" do
  #         text upd_apar_def.defect do
  #           menu type: "context", id: "upd_apar_def_defect_menu_#{upd_apar_def_counter }"
  #           button "Button 1"
  #           menuitem label: "Command 1", type: "command"
  #           menu label: "nested1" do
  #             menuitem label: "Command 2"
  #             menuitem href: "/a/day/at/the/races2" do
  #               text "Grass Hopper2"
  #             end
  #             menuitem href: "/a/day/at/the/races3" do
  #               text "Grass Hopper3"
  #             end
  #           end
  #         end
  #       end
  #       td do
  #         text upd_apar_def.apar
  #       end
  #       td do
  #         text upd_apar_def.ptf
  #       end
  #       td do
  #         text upd_apar_def.abstract
  #       end
  #       td do
  #         text upd_apar_def.lpp
  #       end
  #       td do
  #         text upd_apar_def.vrmf
  #       end
  #       td do
  #         text upd_apar_def.version
  #       end
  #       td do
  #         text upd_apar_def.service_pack
  #       end
  #     end
  #   end
  # end
    
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

  def append_results
    build_html do
      script type: 'text/javascript' do
        text upd_apar_defs.to_json.html_safe
      end
    end
  end

  def to_json(options = {})
    upd_apar_defs.to_json(options)
  end
end
