class SwinfosController < ApplicationController
  respond_to :html, :json

  DEFAULT_SORT_ORDER = 'defect, apar, ptf'

  # Currently I've decided to pass the sort order and the page number
  # as part of the path.  The show routine is called from a url of
  # /swinfos/:item/:sort/:page(.:format) where :item can be a defect,
  # apar, ptf, lpp, or lpp with vrmf.  :sort is a list of columns
  # separated by commands.  :page can be either a number or the string
  # 'all'.
  def show
    unless params[:sort]
      redirect_to swinfo_full_path(params[:item], DEFAULT_SORT_ORDER, 1)
      return
    end

    # check the sort order
    finder_options = order(params[:sort])

    # check the page
    unless params[:page] == "all"
      finder_options[:limit] = 1000
      page = params[:page].to_i
      if page > 1
        finder_options[:offset] = (page - 1) * 1000
      end
    end

    item = params[:item]
    upd_apar_defs = find_items(finder_options, item)
    @view_model = Swinfo.new(:params => params,
                             :title => "swinfo for #{item}",
                             :errors => @errors,
                             :item => item,
                             :upd_apar_defs => upd_apar_defs)
    respond_with(view_model)
  end

  def create
    swinfo = params[:swinfo]
    redirect_to swinfo_full_path(swinfo[:item],
                                 (swinfo[:sort] || DEFAULT_SORT_ORDER),
                                 (swinfo[:page] || 1))
  end

  private

  def find_items(finder_options, item)
    dalli_params = finder_options.merge(:item => item)
    unless (items = Condor3::Application.config.my_dalli.read(dalli_params))
      item_upcase = item.upcase
      case item_upcase
      when /^I[VXYZ][0-9][0-9][0-9][0-9][0-9]$/ # APAR
        items = UpdAparDef.find_all_by_apar(item_upcase, finder_options)
        
        # This pattern may be too tight.  SW123456 and AX123456 fit but
        # there may be other patterns I am not aware off.
      when /^[A-Z][A-Z][0-9][0-9][0-9][0-9][0-9][0-9]$/ # CQ Defect name
        items = UpdAparDef.find_all_by_cq_defect(item_upcase, finder_options)

      when /^[0-9]+$/         # Defect
        items = UpdAparDef.find_all_by_defect(item, finder_options)
        
      when /^[0-9]{4}-[0-9]{2}-[0-9]{2}/, /^VIOS .*/ # service pack
        items = UpdAparDef.find_all_by_service_pack(item_upcase, finder_options)
        
      when /^U[0-9][0-9][0-9][0-9][0-9][0-9]$/ # PTF
        items = UpdAparDef.find_all_by_ptf(item_upcase, finder_options)
      
      when /^([^ :]+)[ :]+([^ :]+)$/ # Fileset name with vrmf
        lpp, vrmf = item.split(/[ :]+/)
        items = UpdAparDef.find_all_by_lpp(lpp, finder_options.merge(:conditions => [ 'vrmf LIKE ?', "#{vrmf}%"]))

      else                        # Just a fileset name
        items = UpdAparDef.find_all_by_lpp(item, finder_options)
      end
      rc = Condor3::Application.config.my_dalli.write(dalli_params, items)
    end
    return items
  end

  def push_error(msg)
    errors << msg
  end

  def errors
    @errors ||= []
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
