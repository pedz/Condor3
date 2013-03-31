#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 

# These are hashes that are used to check that the routes produce what
# the controllers expect.
DiffRouteHash = {
  controller: "diffs",
  action: "show",
  release: 'REL',
  path: 'a/long/file',
  version: '1.2.3.4'
}.freeze

DiffPrevVersionRouteHash = DiffRouteHash.merge(prev_version: '5.6.7.8').freeze
