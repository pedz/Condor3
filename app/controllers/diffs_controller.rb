# -*- coding: utf-8 -*-
#
# Copyright 2012-2013 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#

class DiffsController < ApplicationController
  def show
    new_params = {
      :release => params[:release],
      :version => params[:version],
      :path => params[:path],
      :cmvc => user.cmvc
    }
    if params.has_key? :prev_version
      old_parsms = new_params.merge(:version => params[:prev_version])
    else
      old_params = find_prev_version(new_params)
    end
    
    @diff = SrcFileDiff.new(SrcFile.new(old_params), SrcFile.new(new_params))
  end

  private

  def find_prev_version(params)
    options = {
      :family => 'aix',
      :general => "Versions v, \
                   Versions prev_v, \
                   Path p, \
                   Path prev_p, \
                   Changes c, \
                   Changes prev_c, \
                   Releases r, \
                   Releases prev_r, \
                   Files f, \
                   Files prev_f",
      :where => "r.name = '#{params[:release]}' and \
                 p.name = '#{params[:path]}' and \
                 v.SID = '#{params[:version]}'  and \
                 c.pathId = p.id and \
                 c.fileId = f.id and \
                 c.versionId = v.id and \
                 f.pathId = p.id and \
                 f.releaseId = r.id and \
                 v.previousId = prev_v.id and \
                 prev_v.id = prev_c.versionId and \
                 prev_c.pathId = prev_p.id and \
                 prev_c.fileId = prev_f.id and \
                 prev_f.releaseId = prev_r.id and \
                 r.name >= prev_r.name \
                 ORDER BY prev_r.name DESC \
                 FETCH FIRST 1 ROW ONLY",
      :select => "prev_r.name as release, \
                  prev_p.name as path, \
                  prev_v.SID as sccsid"
    }
    stdout = user.cmvc.report!(options).stdout
    prev_params = {}
    prev_params[:cmvc] = params[:cmvc]
    prev_params[:release], prev_params[:path], prev_params[:version] = stdout.chomp.split(/\|/)
    prev_params
  end
end
