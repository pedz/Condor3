# -*- coding: utf-8 -*-
#
# Copyright 2012 Ease Software, Inc.
# All Rights Reserved
#
class WhichFilesetsController < ApplicationController
  def show
    @path = params[:path]
    return redirect_to which_filesets_path(@path) if request.post?

    files = do_find(@path)
    if files.empty?
      if (md = /(.*)(_?64$|_?32$)/.match(@path))
        @path = md[1]
        files = do_find(@path)
      elsif (md = /^(.*)(32|64)(\..*)$/.match(@path))
        @path = md[1] + md[3]
        files = do_find(@path)
      end
    end

    @paths = {}
    files.each do |f|
      @paths[f.path] = ((@paths[f.path] || []) + f.filesets.map { |fileset| fileset.lpp.name }).sort.uniq
    end
    
    respond_to do |format|
      format.html { render :action => "show" }
      format.xml  {
        render :xml => files.to_xml(:include => { :filesets => { :include => [:lpp, :service_packs] }})
      }
    end
  end
  
  private
  
  def do_find(path)
    AixFile.find(:all,
                 :conditions => ("basename(path) = basename('#{path}') AND " +
                                 "path LIKE '%#{path}'"),
                 :order => "path",
                 :include => [ { :filesets => :lpp }])
  end
end
