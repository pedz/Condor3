class SrcFilesController < ApplicationController
  def show
    options = {
      :release => params[:release],
      :version => params[:version],
      :path => params[:path],
      :cmvc => user.cmvc
    }
    @src_file = SrcFile.new(options)
  end
end
