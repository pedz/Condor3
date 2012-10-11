class DefectsController < ApplicationController
  def show
    defect_name = params[:id]
    @defect = Defect.find_by_name(defect_name)
    if @defect.nil?
      @defect = Defect.new(:name => defect_name)
      lines = @defect.text
      if lines.empty?
        flash[:fatal] = "#{defect_name} not found"
      else
        @defect.save
      end
    end
    
    respond_to do |format|
      format.html # show.html.erb
    end
  end
end
