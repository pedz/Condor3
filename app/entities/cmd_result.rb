# -*- coding: utf-8 -*-
#
# Copyright 2012-2013 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#

# A class that represents the result of a command.  This is little
# more than a Struct.
class CmdResult
  ##
  # :attr: stdout
  # The stdout of the command as a single string
  attr_reader :stdout

  ##
  # :attr: stderr
  # The stderr of the command as a single string
  attr_reader :stderr

  ##
  # :attr: rc
  # The return or exit code of the command as an integer
  attr_reader :rc

  ##
  # :attr: signal
  # The signal received, if any, that terminated the command
  attr_reader :signal

  # Initialized with a hash with keys of :stdout, :stderr, :rc, and :signal
  # * *Args*    :
  #   - +options+ -> A hash containing:
  #     * +:stdout+ -> The standard output from the command
  #     * +:stderr+ -> The standard error from the command
  #     * +:rc+ -> The exit status from the command
  #     * +:signal+ -> The string name of the signal which terminated
  #       the command if any.
  def initialize(options = {})
    @stdout = options.fetch(:stdout, nil)
    @stderr = options.fetch(:stderr, nil)
    @rc =     options.fetch(:rc, nil)
    @signal = options.fetch(:signal, nil)

    # Special cases
    # 1: Just stdout implies rc = 0
    @rc = 0 if (! @stdout.nil?) && (@stderr.nil? && @rc.nil? && @signal.nil?)

    # 2: Just stderr implies rc = 1
    @rc = 1 if (! @stderr.nil?) && (@stdout.nil? && @rc.nil? && @signal.nil?)

    # 3: If signal is set but rc is not, then make rc = -1
    @rc = -1 if (! @signal.blank?) && @rc.nil?

    # 4: if signal is set but stderr is not, then make stderr be a
    # reasonable error message
    if (! @signal.blank?) && @stderr.blank?
      @stderr = "Command terminated by signal #{@signal}"
    end
  end
end
