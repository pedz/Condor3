# -*- coding: utf-8 -*-
#
# Copyright 2012-2013 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#

class GetFileChanges
  ##
  # :attr: defect
  # The defect or feature that was requested
  attr_reader :file_name
  
  ##
  # :attr: changes
  # The changes from the CMVC defect or feature
  attr_reader :changes

  ##
  # :attr: error
  # The error to pass back
  attr_reader :error

  def initialize(options)
    @options = options
    @file_name = @options[:file].strip
    @changes = []
    @error = nil
    
    hash = {
      get_user: @options[:get_user],
      cmd: 'Report',
      family: 'aix',
      general: "Changes c, \
        	Defects d, \
        	Files f, \
        	Path p, \
        	Tracks t, \
        	Levels l, \
        	Releases r, \
        	Versions v, \
        	Versions prev \
        	",
      where: "f.basename = '#{file_name}' AND \
	      f.id = c.fileid AND \
	      c.trackid = t.id AND \
	      d.id = t.defectid AND \
	      f.pathid = p.id AND \
	      t.releaseid = r.id AND \
	      v.id = c.versionid AND \
              prev.id = v.previousId AND \
              l.id IN ( \
	        SELECT l.id \
                  FROM  Levels l, \
                        LevelMembers lm \
                  WHERE lm.trackid = t.id AND \
                        l.id = lm.levelid AND \
                        ( l.type = 'published' or \
                          ( l.type = 'production' AND \
                            NOT EXISTS ( \
                              SELECT * \
                                FROM  Levels l, \
                                      LevelMembers lm \
                                WHERE l.id = lm.levelid AND \
                                      l.type = 'published' AND \
                                      t.id = lm.trackid ) \
                          ) \
                        ) \
                UNION \
	          SELECT l.id \
                    FROM   Levels l, \
                           LevelMembers lm \
                    WHERE  l.name is null AND \
                      NOT EXISTS ( \
	             	SELECT * \
                          FROM  Levels l, \
                                LevelMembers lm \
                          WHERE l.id = lm.levelid AND \
                                l.type in ( 'production', \
                                            'published' ) AND \
                                t.id = lm.trackid ) \
              ) \
              ORDER BY path, rname, c.versionId \
	     ",
      select: "r.name AS release, \
               d.type AS defect_type, \
               d.name AS defect, \
               l.name AS level, \
               v.SID AS sccsid, \
               p.name AS path, \
               c.type, \
               d.reference, \
               prev.SID AS prev_sccsid, \
               d.abstract"
    }

    cmd = execute_cmvc_command.new(hash)
    if (cmd.rc == 0)
      @changes = cmd.stdout.split("\n").map do |line|
        Change.new(*line.split('|', 10))
      end
    else
      @error = cmd.stderr
    end
  end

  private

  def execute_cmvc_command
    @execute_cmvc_command ||= @options[:execute_cmvc_command] || ExecuteCmvcCommand
  end

  # Not used yet
  def cache
    @cache ||= @options[:cache] || Condor3::Application.config.my_dalli
  end
end
