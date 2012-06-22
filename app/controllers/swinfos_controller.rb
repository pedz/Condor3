class SwinfosController < ApplicationController
  ATTR_LIST = [
               :abstract,
               :apar,
               :cq_defect,
               :defect,
               :lpp,
               :ptf,
               :service_pack,
               :version,
               :vrmf
              ]

  METH_LIST = [
               :apar_draft_apar_path,
               :apar_draft_defect_path,
               :changes_path,
               :defect_path,
               :fileset_path,
               :swinfos_apar_path,
               :swinfos_defect_path,
               :swinfos_fileset_path,
               :swinfos_lpp_path,
               :swinfos_ptf_path
              ]
  def show
    logger.debug("Accepts = #{request.accepts.inspect}")
    @param = params[:item]
    find_items
    @json_elements = Hash.new
    @json_elements["items"] = @items
    respond_to do |format|
      format.html { render :action => "show" }
      format.json {
        render :json => @items.to_json(:only => ATTR_LIST, :methods => METH_LIST)
      }
      format.xml  {
        render :xml => @items.to_xml(:only => ATTR_LIST, :methods => METH_LIST)
      }
    end
  end

  private

  def find_items
    unless (@items = Condor3::Application.config.my_dalli.read(@param))
      item = @param
      item_upcase = item.upcase
      case item_upcase
      when /^I[VXYZ][0-9][0-9][0-9][0-9][0-9]$/ # APAR
        @items = UpdAparDef.find_all_by_apar(item_upcase, :order => 'defect, apar, ptf', :limit => 1000)
        
        # This pattern may be too tight.  SW123456 and AX123456 fit but
        # there may be other patterns I am not aware off.
      when /^[A-Z][A-Z][0-9][0-9][0-9][0-9][0-9][0-9]$/ # CQ Defect name
        @items = UpdAparDef.find_all_by_cq_defect(item_upcase, :order => 'defect, apar, ptf', :limit => 1000)

      when /^[0-9]+$/         # Defect
        @items = UpdAparDef.find_all_by_defect(item, :order => 'defect, apar, ptf', :limit => 1000)
        
      when /^U[0-9][0-9][0-9][0-9][0-9][0-9]$/ # PTF
      @items = UpdAparDef.find_all_by_ptf(item_upcase, :order => 'defect, apar, ptf', :limit => 1000)
      
      when /^([^ ]+) +([^ ]+)$/ # Fileset name with vrmf
        lpp, vrmf = item.split(' ')
        @items = UpdAparDef.find_all_by_lpp(lpp, :conditions => [ 'vrmf LIKE ?', "#{vrmf}%"], :order => 'defect, apar, ptf', :limit => 1000)

      else                        # Just a fileset name
        @items = UpdAparDef.find_all_by_lpp(item, :order => 'defect, apar, ptf', :limit => 1000)
      end
    end
    Condor3::Application.config.my_dalli.write(@param, @items)
  end
end
