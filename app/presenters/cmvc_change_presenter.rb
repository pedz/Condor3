# -*- coding: utf-8 -*-
#
# Copyright 2012-2013 Ease Software, Inc.
# All Rights Reserved
#

# cmvc change presenter
class CmvcChangePresenter < ApplicationPresenter
  presents :get_cmvc_defect_changes
  delegate :defect_name, :error, :changes, to: :get_cmvc_defect_changes

  def page_title
    "Changes Introduced by CMVC #{type}#{defect_name}"
  end

  def type
    if changes.length > 0 && changes[0].defect_type
      "#{changes[0].defect_type.capitalize} "
    else
      ""
    end
  end

  def help_text
    build_html do
      p "Lots more help needed here"
    end
  end
  
  def show_changes
    Rails.logger.debug("here!!!")
    if error.blank?
      build_html do
        changes.each do |change|
          defect = change.defect
          ul.defect do
            li do
              "Defect #{link_to defect, swinfo_get_path(defect)}: #{change.abstract}"
              until change.nil? || change.defect != defect
                release = change.release
                ul.release do
                  li do
                    "Product #{release} [#{change.level}]"
                    until change.nil? || change.release != release
                      ul.change do
                        li do
                          if change.prev_sccsid.nil?
                            "Initial Drop"
                          else
                            link_to(change.prev_sccsid,
                                    src_files_path(change.release,
                                                   change.path.split(/\//),
                                                   change.prev_sccsid))
                            link_to("->",
                                    diffs_path(change.release,
                                               change.path.split(/\//),
                                               change.sccsid))
                          end
                          link_to(change.sccsid,
                                  src_files_path(change.release,
                                                 change.path.split(/\//),
                                                 change.sccsid))
                          change.type
                          change.path
                          change = changes.shift
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    else
      error_block(error)
    end
  end
end
