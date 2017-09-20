#!/usr/bin/env ruby
# -*- coding: binary -*-
#
# Copyright 2012 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#

# For VIO, use these two instead
GSA_BASE=Pathname.new("/gsa/ausgsa/projects/s/service/images/61/update")
GSA_PATTERN = GSA_BASE + "VIOS_*"

require 'lib/tasks/scan_gsa'
