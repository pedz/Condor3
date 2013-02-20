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
  
  def initialize(options)
    @options = options.dup
    @defect_name = options[:cmvc_defect]

    hash = {
      get_user: options[:get_user],
      cmd: 'Defect',
      view: @defect_name,
      family: 'aix',
      long: nil
    }
    
    @cmd = model.new(hash)
    if (@cmd.rc != 0)
      # if Defect fails, try Feature
      cmd2 = model.new(hash.merge(cmd: 'Feature'))
      # if Feature works, then use that result
      if (cmd2.rc == 0)
        @cmd = cmd2
      end
    end
  end

  private

  def model
    @model ||= @options[:model] || ExecuteCmvcCommand
  end

  # Not used yet
  def cache
    @cache ||= @options[:cache] || Condor3::Application.config.my_dalli
  end

  # # Retrieves the text of the defect from CMVC.
  # def fetch_text(cmvc)
  #   options = {
  #     :view => name,
  #     :family => 'aix',
  #     :long => ""
  #   }
  #   begin
  #     @cmd = cmvc.defect!(options)
  #   rescue Cmvc::CmvcError => err
  #     begin
  #       @cmd = cmvc.feature(options)
  #       raise err unless @cmd.rc == 0
  #     end
  #   end
  # end

  # # Returns text as an array of lines
  # def lines
  #   @cmd.lines
  # end

  # # Returns the text of the Defect or Feature
  # def text
  #   @cmd.stdout
  # end
end
