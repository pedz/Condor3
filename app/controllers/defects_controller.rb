class DefectsController < ApplicationController
  def show
    @defect_name = params[:defect]
    return redirect_to defects_path(@defect_name) if request.post?
    @defect = Defect.find_by_name(@defect_name)
    @lines, @err = defect_text(@defect_name)

    if @defect.nil? &&! @lines.blank?
      @defect = Defect.new
      @defect.name = @defect_name
      @defect.save
    end
    
    respond_to do |format|
      format.html # show.html.erb
    end
  end

  private

  def defect_text(defect_name)
    options = {
      :view => defect_name,
      :family => 'aix',
      :long => ""
    }
    stdout, stderr1, rc, signal = user.cmvc.defect(options)
    return stdout, nil if rc == 0
    stdout, stderr2, rc, signal = user.cmvc.feature(options)
    return stdout, nil  if rc == 0
    return nil, "#{stderr1}#{stderr2}"
  end
end
