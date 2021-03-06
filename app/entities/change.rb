# -*- coding: utf-8 -*-
#
# Copyright 2012-2013 Ease Software, Inc.
# All Rights Reserved
#

# Roughly matches a Change record from CMVC which represents a change
# to a source file introduced by a defect or feature.
class Change
  ##
  # :attr: release
  # The CMVC release the Change is made in
  attr_reader :release

  ##
  # :attr: defect_type
  # Either "defect" or "feature"
  attr_reader :defect_type

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

  # * *Args*    :
  #   - +release+ -> The CMVC release such as bos53X
  #   - +defect_type+ -> Either "defect" or "feature"
  #   - +defect+ -> The CMVC defect or feature number
  #   - +level+ -> The build level name
  #   - +sccsid+ -> The SCCS id string
  #   - +path+ -> The path to the file
  #   - +type+ -> The type of change
  #   - +reference+ -> The reference from the defect
  #   - +prev_sccsid+ -> The previous SCCS id for this file.
  #   - +abstract+ -> The abstract from the defect or feature.
  def initialize(release, defect_type, defect, level, sccsid, path, type, reference,
                 prev_sccsid, abstract)
    @release = release
    @defect_type = defect_type
    @defect = defect
    @level = level
    @sccsid = sccsid
    @path = path
    @type = type
    @reference = reference
    @prev_sccsid = prev_sccsid
    @abstract = abstract
  end
end
