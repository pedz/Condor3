# -*- coding: utf-8 -*-
#
# Copyright 2012 Ease Software, Inc.
# All Rights Reserved
#

# Roughly matches a Change record from CMVC which represents a change
# to a source file introduced by a defect or feature.
class Change
  ##
  # :attr: release
  # The CMVC release the Change is made in

  ##
  # :attr: defect
  # The CMVC defect that made the Change

  ##
  # :attr: level
  # The CVMC Level of the change.  A level might be thought of as a
  # build level.

  ##
  # :attr: sccsid
  # The SCCS id for the file created by the Change.

  ##
  # :attr: path
  # The Path of the AIX source file.

  ##
  # :attr: type
  # The Type of change which can be such things as the initial drop,
  # link, or an actual code change.

  ##
  # :attr: reference
  # The "reference" mentioned in the defect -- sometimes used to point
  # to the defect that introduced a bug that the current defect
  # attempts to fix.

  ##
  # :attr: abstract
  # The abstract of the defect

  ##
  # :attr: prev_sccsid
  # The previous SCCS id of the file before the Change.
  
  attr_reader :release, :defect, :level, :sccsid, :path, :type, :reference
  attr_reader :abstract, :prev_sccsid

  def initialize(release, defect, level, sccsid, path, type, reference,
                 abstract, prev_sccsid = nil)
    @release = release
    @defect = defect
    @level = level
    @sccsid = sccsid
    @path = path
    @type = type
    @reference = reference
    @abstract = abstract
    @prev_sccsid = prev_sccsid
  end

  # When passed a defect, makes a query to CMVC for the list of
  # code Changes introduced by that defect.
  def self.find(defect)
    changes = []
    IO.popen("/usr/local/cmvc/bin/Report \
       -family aix \
       -become pedzan \
       -general \"Changes c, \
		 Defects d, \
		 Files f, \
		 Path p, \
		 Tracks t, \
		 Levels l, \
		 Releases r, \
		 Versions v, \
		 Versions prev \
		 \" \
       -where \" \
		 d.name = '#{defect}' and \
		 d.id = t.defectid and \
		 c.trackid = t.id and \
		 f.id = c.fileid and \
		 f.pathid = p.id and \
		 t.releaseid = r.id and \
		 v.id = c.versionid and \
		 prev.id = v.previousId and \
                 l.id in ( \
		          select l.id \
                          from   Levels l, \
                                 LevelMembers lm \
                          where  lm.trackid = t.id and \
                                 l.id = lm.levelid and \
                               ( l.type = 'published' or \
                                 ( l.type = 'production' and \
                                   not exists ( \
                                       select * \
                                       from   Levels l, \
                                              LevelMembers lm \
                                       where  l.id = lm.levelid and \
                                              l.type = 'published' and \
                                              t.id = lm.trackid ) \
                                 ) \
                               ) \
                        union \
		          select l.id \
                          from   Levels l, \
                                 LevelMembers lm \
                          where  l.name is null and \
                                 not exists ( \
				     select * \
                                     from  Levels l, \
                                           LevelMembers lm \
                                     where l.id = lm.levelid and \
                                           l.type in ( 'production', \
                                                       'published' ) and \
                                           t.id = lm.trackid ) \
                        ) \
    order by defect, release, path, sccsid \
	       \" \
       -select \"\
	        r.name as release, \
	        d.name as defect, \
		l.name as level, \
		v.SID as sccsid, \
		p.name as path, \
		c.type, \
		d.reference, \
		d.abstract, \
		prev.SID as prev_sccsid \
                ") do |io|
      io.each_line do |line|
        line.chomp!
        RAILS_DEFAULT_LOGGER.debug("line is #{line}")
        changes << new(*line.split(/\|/))
      end
    end
    changes
  end
end
