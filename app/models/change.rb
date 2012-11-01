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
end
