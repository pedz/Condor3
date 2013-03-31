# -*- coding: utf-8 -*-
#
# Copyright 2012-2013 Ease Software, Inc.
# All Rights Reserved
#

# Presents a GetDiff
class DiffPresenter < ApplicationPresenter
  presents :get_diff
  delegate :error, :page_params, :old_file, :old_seq, :new_file, :new_seq, :diff_count, to: :get_diff

  def page_title
    "diff #{page_params[:release]} #{page_params[:path]} #{page_params[:version]}"
  end

  def help_text
    build_html do
      p "Lots of help needed here..."
    end
  end

  def show_controls
    if error
      return ""
    end
    build_html do
      div id: 'control-table' do
        div.control! do 
          button("Prev", id: "prev-diff")
          text "Hunk "
          span(0, id: "hunk-index")
          text " of "
          span(diff_count, id: "hunk-count")
          button("Next", id: "next-diff")
        end
      end
    end
  end

  def show_changes
    if error.blank?
      build_html do
        put_file_div(old_seq, "top", old_file)
        put_file_div(new_seq, "bot", new_file)
      end
    else
      error_block(error)
    end
  end

  private

  def put_file_div(lines, which, src_file)
    div id: "#{which}-title-table" do
      div id: "#{which}-title" do
        "#{src_file.release} #{src_file.path} #{src_file.version}"
      end
    end
    div id: which do
      @last_num = nil
      lines.each do |type, num, line_id|
        attr_hash = { class: "code #{type.gsub(/_/, '-')}"}
        if line_id
          line = line_id
        else
          line = " "
        end
        if type != "match" && @last_num != num
          attr_hash[:id] = "diff-#{which}-#{num}"
        end
        @last_num = num
        pre attr_hash do
          line
        end
      end
    end
  end
end

# <div id="<%= h which %>">
#   <% last_num = nil -%>
#   <% lines.each do |type, num, line_id| -%>
#     <% css_id, css_class, line = get_id_class_line(line_id, type, which, last_num, num) -%>
#     <% last_num = num -%>
#     <pre <%= css_id %> <%= css_class %> ><%= h line %></pre>
#   <% end -%>
# </div>
#
#   def get_id_class_line(line_id, type, which, last_num, num)
#     if type == "match"
#       css_id = ""
#       css_class = "class=\"code\""
#     else
#       if last_num != num
#         css_id = "id=\"diff-#{which}-#{num}\""
#       else
#         css_id = ""
#       end
#       css_class = "class=\"code #{type.gsub(/_/, '-')}\""
#     end
#     # line = line_id.nil? ? " " : StringTable.lookup(line_id).chomp
#     line = line_id.nil? ? " " : line_id.chomp
#     return css_id.html_safe, css_class.html_safe, line
#   end
#
# <% @title = "Diff #{@diff.new_file.basename} #{@diff.old_file.version} -> #{@diff.new_file.version}" %>
# <div id="control-table">
# </div>
# <%= put_file_div(@diff.callbacks.old_seq, "top", @diff.old_file) %>
# <%= put_file_div(@diff.callbacks.new_seq, "bot", @diff.new_file) %>
