# -*- coding: utf-8 -*-
#
# Copyright 2012-2013 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#

class ExecuteCmvcCommand
  def initialize(options)
    @options = options.dup

    cmvc = GetCmvcFromUser.new(@options)
    
    cmd = @options.delete(:cmd)
  end
end
