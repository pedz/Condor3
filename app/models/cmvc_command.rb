# -*- coding: utf-8 -*-
#
# Copyright 2012 Ease Software, Inc.
# All Rights Reserved
#

# A model representing the results of a CMVC Command
class CmvcCommand
  # The Cmvc used for the command
  attr_reader :cmvc

  # The command itself
  attr_reader :cmd

  # The options used to generate the command
  attr_reader :options
  
  # The stdout from the command
  attr_reader :stdout

  # The stderr from the command
  attr_reader :stderr

  # The return code (exit status) fro the command
  attr_reader :rc

  # The signal received causing the command to terminate (if any)
  attr_reader :signal

  def initialize(cmvc, cmd, options, stdout, stderr, rc, signal)
    @cmvc, @cmd, @options, @stdout, @stderr, @rc, @signal = cmvc, cmd, options, stdout, stderr, rc, signal
  end

  # stdout returned as an array of lines broken at new lines
  def lines
    @lines ||= @stdout.split("\n")
  end
end
