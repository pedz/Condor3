# -*- coding: utf-8 -*-
#
# Copyright 2012-2013 Ease Software, Inc.
# All Rights Reserved
#

# Presents a GetCmvcDefectChange
class CmvcDefectChangePresenter < ApplicationPresenter
  presents :get_cmvc_defect_changes
  delegate :defect_name, :error, :changes, to: :get_cmvc_defect_changes

  # Returns the text string for the title of the page
  def page_title
    "Changes Introduced by CMVC #{type}#{defect_name}"
  end

  # Returns HTML for the help text of the page.
  def help_text
    build_html do
      p <<-P1
        This is the list of changes that a particular defect or
  feature introduced.  The changes are grouped by release.  Each
  change provides a link to the file or files involved along with a
  link to a diff of the changes for that file.  The link to the diff
  is the '->' between the two SCCS ids.
        P1
    end
  end
  
  # Returns HTML for the changes the defect created.
  def show_changes
    if error.blank?
      build_html do
        c_enum = changes.to_enum
        div.defect do
          describe_defect_changes(c_enum)
        end
      end
    else
      error_block(error)
    end
  end

  private

  # Called from page_title to determine if this was a Feature or a
  # Defect.
  def type
    if changes.length > 0 && changes[0].defect_type
      "#{changes[0].defect_type.capitalize} "
    else
      ""
    end
  end

  # The outter most loop of the changes.  Creates an unordered list of
  # releases the defect hit.
  def describe_defect_changes(enum)
    begin
      change = enum.peek
    rescue StopIteration
      return ""
    end
    span do
      defect_heading(change)
    end
    ul.defect do
      list_defect_changes(enum)
    end
  end

  # The HTML needed to present the head of the defect.
  def defect_heading(change)
    defect = change.defect
    text change.defect_type.capitalize
    text ' '
    a(defect, href: swinfo_get_path(defect))
    text ": "
    text change.abstract
  end

  # Creates the HTML listing the releases the CMVC hit.
  def list_defect_changes(enum)
    change = enum.peek
    defect = change.defect
    loop do
      break if change.defect != defect
      li do
        describe_changes_within_release(enum)
      end
      begin
        change = enum.peek
      rescue StopIteration
        break
      end
    end
  end

  # Creates an unordered HTML list describing the changes for the
  # defect within a particular release.
  def describe_changes_within_release(enum)
    change = enum.peek
    span "Product #{change.release} [#{change.level}]"
    ul.release do
      list_changes_within_release(enum)
    end
  end

  # Creates the list items for the changes for the defect within a
  # particular release
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

  # Creates the HTML for an individual change.
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
    text ' '
    text change.type
    text ' '
    text change.path
  end
end
