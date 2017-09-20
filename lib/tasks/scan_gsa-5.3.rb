#!/usr/bin/env ruby
# -*- coding: binary -*-
#
# Copyright 2012 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#

# AIX 5.3 base and pattern
GSA_BASE    = Pathname.new("/gsa/ausgsa/projects/a/aix")
GSA_PATTERN = GSA_BASE + "aix53[XYZ]/5300-{??Gold,*_SP}/{update,inst}.images"

require 'lib/tasks/scan_gsa'
