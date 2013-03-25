# -*- coding: utf-8 -*-
#
# Copyright 2012-2013 Ease Software, Inc.
# All Rights Reserved
#

# cmvc change presenter
class FileChangePresenter < ApplicationPresenter
  presents :get_file_changes
  delegate :file_name, :error, :changes, to: :get_file_changes

  def page_title
    "Changes to #{file_name}"
  end

  def help_text
    build_html do
      p "Lots more help needed here"
    end
  end
  
  def show_changes
    if error.blank?
      build_html do
        c_enum = changes.to_enum
        div.changes do
          describe_changes(c_enum)
        end
      end
    else
      error_block(error)
    end
  end

  private

  def describe_changes(enum)
    begin
      change = enum.peek
    rescue StopIteration
      return ""
    end
    span do
      file_heading(change)
    end
    ul.path do
      list_paths(enum)
    end
  end

  def file_heading(change)
    text "File #{change.path}"
  end

  def list_paths(enum)
    change = enum.peek
    path = change.path
    loop do
      break if change.path != path
      li do
        describe_changes_within_path(enum)
      end
      begin
        change = enum.peek
      rescue StopIteration
        break
      end
    end
  end

  def describe_changes_within_path(enum)
    change = enum.peek
    span "Product #{change.release} [#{change.level}]"
    ul.release do
      list_changes_within_release(enum)
    end
  end

  def list_changes_within_release(enum)
    change = enum.peek
    release = change.release
    while change.release == release
      li do
        describe_single_change(change)
      end
      begin
        enum.next
        change = enum.peek
      rescue StopIteration
        break
      end
    end
  end

  def describe_single_change(change)
    split_path = change.path.split(/\//)
    if change.prev_sccsid.blank?
      text "Initial Drop"
    else
      a(change.prev_sccsid, href: src_files_path(change.release,
                                                 split_path,
                                                 change.prev_sccsid))
      text ' '
      a("->", href: diffs_path(change.release,
                               split_path,
                               change.sccsid))
    end
    text ' '
    a(change.sccsid, href: src_files_path(change.release,
                                          split_path,
                                          change.sccsid))
    text " #{change.defect_type.capitalize} "
    a(change.defect, href: swinfo_get_path(change.defect))
    text " #{change.abstract}"
  end
end