#!/usr/bin/env ruby
# -*- coding: binary -*-
#
# Copyright 2012 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#

# 7.1 base and pattern
GSA_BASE    = Pathname.new("/gsa/ausgsa/projects/a/aix")
GSA_PATTERN = GSA_BASE + "aix71[Q-Z]/7100-{*Gold,*_SP}/{update,inst}.images"

require 'lib/tasks/scan_gsa'
