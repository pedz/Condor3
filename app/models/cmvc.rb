# -*- coding: utf-8 -*-
#
# Copyright 2012 Ease Software, Inc.
# All Rights Reserved
#

# A model representing the CMVC user id.
class Cmvc < ActiveRecord::Base

  # This exception is thrown when the bang commands, e.g. report!,
  # return with an error
  class CmvcError < Exception
    # The CmvcCommand that was executed.
    attr_reader :cmd
    
    def initialize(cmd)
      @cmd = cmd
      super(@cmd.stderr)
    end
  end

  ##
  # :attr: id
  # The Integer primary key for the table.

  ##
  # :attr: user_id
  # The id from the User record
  
  ##
  # :attr: login
  # The actual CMVC login name.

  ##
  # :attr: created_at
  # Rails normal created_at timestamp that is when the db record was
  # created.

  ##
  # :attr: updated_at
  # Rails normal updated_at timestamp.  Each time the db record is
  # saved, this gets updated.

  ##
  # :attr: user
  # A belongs_to association to the User record.
  belongs_to :user

  %w{ report file defect feature }.each do |cmd|
    cap = cmd.capitalize
    binding.eval <<-EOF, __FILE__, __LINE__
      def #{cmd}(options = {})
        common_command(options, "#{cap}")
      end

      def #{cmd}!(options = {})
        result = #{cmd}(options)
        raise CmvcError.new(result) unless result.rc == 0
        result
      end
    EOF
  end

  private

  def common_command(options, cmd)
    cmd = [ cmd , "-become", login ]
    options.each_pair do |k, v|
      # We could add checking of the options to make sure they fit
      # with the command but lets just let cmvc check on its own.
      cmd << "-#{k}"
      cmd << "\"#{v}\"" unless v.blank?
    end
    # squeeze out extra white space for readability
    cmd = cmd.join(' ').gsub(/[ \t\n\r]+/, ' ')
    logger.debug("CMD= #{cmd}")
    stdout, stderr, rc, signal = CmvcHost.exec(cmd)
    CmvcCommand.new(self, cmd, options, stdout, stderr, rc, signal)
  end
end
