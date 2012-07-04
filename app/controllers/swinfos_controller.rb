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

  DEFAULT_SORT_ORDER = 'defect, apar, ptf'

  # Currently I've decided to pass the sort order and the page number
  # as part of the path.  The show routine is called from a url of
  # /swinfos/:item/:sort/:page(.:format) where :item can be a defect,
  # apar, ptf, lpp, or lpp with vrmf.  :sort is a list of columns
  # separated by commands.  :page can be either a number or the string
  # 'all'.
  def show
    # logger.debug("Accepts = #{request.accepts.inspect}")
    # ENV.keys.each do |key|
    #   logger.debug"ENV['#{key}'] = '#{ENV[key]}'"
    # end
    # env.keys.each do |key|
    #   logger.debug"env['#{key}'] = '#{env[key]}'"
    # end

    # check the sort order
    @params = order(params[:sort])

    # check the page
    unless params[:page] == "all"
      @params[:limit] = 1000
      page = params[:page].to_i
      if page > 1
        @params[:offset] = (page - 1) * 1000
      end
    end

    @item = params[:item]
    find_items
    @json_elements = Hash.new
    @json_elements["items"] = @items
    respond_to do |format|
      format.html { render :action => "show" }
      format.json {
        # render :json => @items.to_json(:only => ATTR_LIST, :methods => METH_LIST)
        render :json => @items.to_json
      }
      format.xml  {
        render :xml => @items.to_xml(:only => ATTR_LIST, :methods => METH_LIST)
      }
    end
  end

  private

  def find_items
    dalli_params = @params.merge :item => @item
    unless (@items = Condor3::Application.config.my_dalli.read(dalli_params))
      item_upcase = @item.upcase
      case item_upcase
      when /^I[VXYZ][0-9][0-9][0-9][0-9][0-9]$/ # APAR
        @items = UpdAparDef.find_all_by_apar(item_upcase, @params)
        
        # This pattern may be too tight.  SW123456 and AX123456 fit but
        # there may be other patterns I am not aware off.
      when /^[A-Z][A-Z][0-9][0-9][0-9][0-9][0-9][0-9]$/ # CQ Defect name
        @items = UpdAparDef.find_all_by_cq_defect(item_upcase, @params)

      when /^[0-9]+$/         # Defect
        @items = UpdAparDef.find_all_by_defect(@item, @params)
        
      when /^[0-9]{4}-[0-9]{2}-[0-9]{2}/, /^VIOS .*/
        @items = UpdAparDef.find_all_by_service_pack(item_upcase, @params)
        
      when /^U[0-9][0-9][0-9][0-9][0-9][0-9]$/ # PTF
        @items = UpdAparDef.find_all_by_ptf(item_upcase, @params)
      
      when /^([^ ]+)[ :]+([^ ]+)$/ # Fileset name with vrmf
        lpp, vrmf = @item.split(/[ :]+/)
        @items = UpdAparDef.find_all_by_lpp(lpp, @params.merge(:conditions => [ 'vrmf LIKE ?', "#{vrmf}%"]))

      else                        # Just a fileset name
        @items = UpdAparDef.find_all_by_lpp(@item, @params)
      end
      rc = Condor3::Application.config.my_dalli.write(dalli_params, @items)
    end
  end

  def push_error(msg)
    (@errors ||= []) << msg
  end

  # param is the :order paramter passed in.  Returns hash to be used
  # for db search.  params is a comma separate list of columns.  Each
  # can be preceded with a + or -.  + for ascending (the default) and
  # - for descending
  VALID_COLUMNS = UpdAparDef.columns.map{ |c| c.name }
  COLUMN_REGEXP = Regexp.new("([-+])?(.*)")
  def order(param)
    list = []
    param.split(/, */).each do |column_text|
      dir, column = COLUMN_REGEXP.match(column_text)[1 .. 2]
      unless VALID_COLUMNS.include?(column)
        push_error("invalid column #{column} in sort order -- ignoring sort order")
        return { order: DEFAULT_SORT_ORDER }
      end
      dir = ((dir == "-") ? "DESC" : "ASC")
      list << "\"#{column}\" #{dir}"
    end
    { order: list.join(', ')}
  end
end
