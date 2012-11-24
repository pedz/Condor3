# -*- coding: utf-8 -*-
#
# Copyright 2012 Ease Software, Inc.
# All Rights Reserved
#

# A similar model to Change.  The two models could probably be merged.
# This model's find method returns the changes that a particular
# source file has undergone.
class FileChange
  ##
  # :attr: release
  # The CMVC release the Change is made in
  attr_reader :release

  ##
  # :attr: defect
  # The CMVC defect that made the Change
  attr_reader :defect

  ##
  # :attr: level
  # The CVMC Level of the change.  A level might be thought of as a
  # build level.
  attr_reader :level

  ##
  # :attr: sccsid
  # The SCCS id for the file created by the Change.
  attr_reader :sccsid

  ##
  # :attr: path
  # The Path of the AIX source file.
  attr_reader :path

  ##
  # :attr: type
  # The Type of change which can be such things as the initial drop,
  # link, or an actual code change.
  attr_reader :type

  ##
  # :attr: reference
  # The "reference" mentioned in the defect -- sometimes used to point
  # to the defect that introduced a bug that the current defect
  # attempts to fix.
  attr_reader :reference

  ##
  # :attr: abstract
  # The abstract of the defect
  attr_reader :abstract

  ##
  # :attr: prev_sccsid
  # The previous SCCS id of the file before the Change.
  attr_reader :prev_sccsid

  def initialize(release, defect, level, sccsid, path, type, reference,
                 prev_sccsid, abstract)
    @release = release
    @defect = defect
    @level = level
    @sccsid = sccsid
    @path = path
    @type = type
    @reference = reference
    @abstract = abstract
    @prev_sccsid = prev_sccsid unless prev_sccsid.empty?
    fetch_changes
  end

  private
  
  # When passed a file, returns the list of changes made to that file.
  # Currently file is assumed to be the basename of the file.
  def self.find(file)
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
                 f.basename = '#{file}' and \
		 f.id = c.fileid and \
		 c.trackid = t.id and \
		 d.id = t.defectid and \
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
                                       from Levels l, \
                                            LevelMembers lm \
                                       where l.id = lm.levelid and \
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
                 order by path, rname, c.versionId \
	       \" \
       -select \"\
	        r.name as rname, \
	        d.name, \
		l.name, \
		v.SID as sccsid, \
		p.name as path, \
		c.type, \
		d.reference, \
                prev.SID as prev_sccsid, \
		d.abstract \
                \"") do |io|
      io.each_line do |line|
        line.chomp!
        RAILS_DEFAULT_LOGGER.debug("line is #{line}")
        changes << new(*line.split(/\|/, 9))
      end
    end
    changes
  end
end
