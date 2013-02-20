# -*- coding: utf-8 -*-
#
# Copyright 2012-2013 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#

class GetCmvcDefectChanges
  ##
  # :attr: defect
  # The defect or feature that was requested
  attr_reader :defect_name
  
  def initialize(options)
    @options = options
    @defect_name = options[:change]

    # find or initialize the record and fetch the text.
    @defect = Defect.find_or_initialize_by_name(@defect_name)
    @defect.fetch_text(user.cmvc)

    # If this is a new record and fetch_text did not throw an
    # exception, we know it is a valid defect number and can save it.
    @defect.save if @defect.new_record?
  end

  private

  def user
    @user ||= @options[:get_user].call
  end

  # private

  # def change_text(defect)
  #   options = {
  #     :family => 'aix',
  #     :general => "Changes c, \
  #       	 Defects d, \
  #       	 Files f, \
  #       	 Path p, \
  #       	 Tracks t, \
  #       	 Levels l, \
  #       	 Releases r, \
  #       	 Versions v, \
  #       	 Versions prev \
  #       	 ",
  #     :where => "d.name = '#{defect}' and \
  #       	 d.id = t.defectid and \
  #       	 c.trackid = t.id and \
  #       	 f.id = c.fileid and \
  #       	 f.pathid = p.id and \
  #       	 t.releaseid = r.id and \
  #       	 v.id = c.versionid and \
  #       	 prev.id = v.previousId and \
  #                l.id in ( \
  #       	          select l.id \
  #                         from   Levels l, \
  #                                LevelMembers lm \
  #                         where  lm.trackid = t.id and \
  #                                l.id = lm.levelid and \
  #                              ( l.type = 'published' or \
  #                                ( l.type = 'production' and \
  #                                  not exists ( \
  #                                      select * \
  #                                      from   Levels l, \
  #                                             LevelMembers lm \
  #                                      where  l.id = lm.levelid and \
  #                                             l.type = 'published' and \
  #                                             t.id = lm.trackid ) \
  #                                ) \
  #                              ) \
  #                       union \
  #       	          select l.id \
  #                         from   Levels l, \
  #                                LevelMembers lm \
  #                         where  l.name is null and \
  #                                not exists ( \
  #       			     select * \
  #                                    from  Levels l, \
  #                                          LevelMembers lm \
  #                                    where l.id = lm.levelid and \
  #                                          l.type in ( 'production', \
  #                                                      'published' ) and \
  #                                          t.id = lm.trackid ) \
  #                       ) \
  #                order by defect, release, path, sccsid",
  #     :select => "r.name as release, \
  #                 d.name as defect, \
  #       	  l.name as level, \
  #       	  v.SID as sccsid, \
  #       	  p.name as path, \
  #       	  c.type, \
  #       	  d.reference, \
  #       	  d.abstract, \
  #       	  prev.SID as prev_sccsid"
  #   }
  #   user.cmvc.report!(options).lines.map { |line| Change.new(*line.split('|'))}
  # end
end
