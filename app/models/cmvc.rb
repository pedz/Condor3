# -*- coding: utf-8 -*-
#
# Copyright 2012 Ease Software, Inc.
# All Rights Reserved
#

# A model representing the CMVC user id.
class Cmvc < ActiveRecord::Base
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

  def report(options = {})
    common_command(options, "Report")
  end

  def defect(options = {})
    common_command(options, "Defect")
  end

  def feature(options = {})
    common_command(options, "Feature")
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
    cmd = cmd.join(' ')
    logger.debug("CMD= #{cmd}")
    CmvcHost.exec(cmd)
  end
end
