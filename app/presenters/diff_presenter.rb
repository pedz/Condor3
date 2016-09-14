# -*- coding: utf-8 -*-
#
# Copyright 2012-2013 Ease Software, Inc.
# All Rights Reserved
#

# Presents a GetDiff
class DiffPresenter < ApplicationPresenter
  presents :get_diff
  delegate :error, :page_params, :old_file, :old_seq, :new_file, :new_seq, :diff_count, to: :get_diff

  # The page title comes from page_params
  def page_title
    "diff #{page_params[:release]} #{page_params[:path]} #{page_params[:version]}"
  end

  # The help text.
  def help_text
    t = <<-P1
<p>
      The original file is on the top and the new file is on the
      bottom. Use the prev and next buttons to move from change to
      change.  The view port of the two files should update to show
      you the change.
</p><p>
      In the top file, you will see red lines which have been deleted
      and yellow lines which have changed.  In the bottom file, you
      will see green lines which have been added and yellow lines
      which match the yellow lines of the top file and indicate that
      that line has changed.
</p>
P1
    return t.html_safe
  end

  # If now errors, produces the HTML for the control section of the
  # page.
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

  # If an error has occurred, produces the HTML to display the error.
  # Otherwise, this produces the four sections to display the two
  # files and their respective heading.
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

  # This produces the file heading and the file's lines as two HTML
  # div's.
  def put_file_div(lines, which, src_file)
    div id: "#{which}-title-table" do
      div id: "#{which}-title" do
        "#{src_file.release} #{src_file.path} #{src_file.version}"
      end
    end
    div id: which do
      @last_num = nil

      length = lines.length
      digits = 1
      while (length > 0)
        length /= 10
        digits += 1
      end

      lineno = 0
      fmt = "%#{digits}d|%s"
      lines.each do |type, num, line_id|
        attr_hash = { class: "code #{type.gsub(/_/, '-')}"}
        if line_id
          lineno += 1
          line = fmt % [ lineno, line_id ]
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
