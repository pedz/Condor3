# -*- coding: utf-8 -*-
#
# Copyright 2012-2013 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#

class GetCmvcDefectTextLines
  ##
  # :attr: defect
  # The defect or feature that was requested
  attr_reader :defect_name
  
  ##
  # :attr: type
  # Set to either "Feature" or "Defect"
  attr_reader :type

  ##
  # :attr: lines
  # The lines from the CMVC defect or feature
  attr_reader :lines

  ##
  # :attr: error
  # The error to pass back
  attr_reader :error

  # Fetches the cmvc text for the defect specified by the :cmvc_defect
  # attribute in the options hash
  def initialize(options)
    @options = options.dup
    @defect_name = @options[:cmvc_defect].strip
    @lines = nil
    @error = nil

    hash = {
      get_user: @options[:get_user],
      cmd: 'Defect',
      view: @defect_name,
      family: 'aix',
      long: nil
    }
    
    cmd = execute_cmvc_command.new(hash)
    @type = 'Defect'
    
    # if Defect fails, try Feature
    if (cmd.rc != 0)
      cmd2 = execute_cmvc_command.new(hash.merge(cmd: 'Feature'))

      # if Feature works, then use that result
      if (cmd2.rc == 0)
        cmd = cmd2
        @type = 'Feature'
      end
    end

    # If the command worked, then stdout will be the lines
    if (cmd.rc == 0)
      @lines = cmd.stdout
    else                        # otherwise, stderr is the error message
      @error = cmd.stderr
    end
  end

  private

  def execute_cmvc_command
    @execute_cmvc_command ||= @options[:execute_cmvc_command] || ExecuteCmvcCommand
  end

  # Not used yet
  def cache
    @cache ||= @options[:cache] || Condor3::Application.config.my_dalli
  end
end
