# -*- coding: utf-8 -*-
#
# Copyright 2012-2013 Ease Software, Inc.
# All Rights Reserved
#

# A model passed to the view from the SwinfosController
class GetSwinfos
  ##
  # :attr: errors
  # Errors hit when processing the request
  attr_reader :errors

  ##
  # :attr: item
  # The item that was searched for
  attr_reader :item

  ##
  # :attr: upd_apar_defs
  # The upd_apar_defs returned from the search
  attr_reader :upd_apar_defs

  # Options should contain :item, :page, and :sort
  # May also have :model to speficy the model to search which defaults
  # to UpdAparDef.  Also may have :cache for the cache which defaults
  # to Condor3::Application.config.my_dalli (yea... that sucks but I'm
  # growing :-)
  def initialize(options = {})
    @options = options.dup
    @item = @options[:item]
    
    # check the sort order
    finder_options, @errors = order(@options[:sort])

    # check the page
    unless @options[:page] == "all"
      finder_options[:limit] = 1000
      page = @options[:page].to_i
      if page > 1
        finder_options[:offset] = (page - 1) * 1000
      end
    end

    @upd_apar_defs = find_items(finder_options, item)
  end

  private

  def model
    @model ||= @options[:model] || UpdAparDef
  end

  def cache
    @cache ||= @options[:cache] || Condor3::Application.config.my_dalli
  end

  # find the items
  def find_items(finder_options, item)
    dalli_params = finder_options.merge(item: item)
    unless (items = cache.read(dalli_params))
      item_upcase = item.upcase
      case item_upcase
      when /^I[VXYZ][0-9][0-9][0-9][0-9][0-9]$/ # APAR
        items = model.find_all_by_apar(item_upcase, finder_options)
        
        # This pattern may be too tight.  SW123456 and AX123456 fit but
        # there may be other patterns I am not aware off.
      when /^[A-Z][A-Z][0-9][0-9][0-9][0-9][0-9][0-9]$/ # CQ Defect name
        items = model.find_all_by_cq_defect(item_upcase, finder_options)

      when /^[0-9]+$/         # Defect
        items = model.find_all_by_defect(item, finder_options)
        
      when /^[0-9]{4}-[0-9]{2}-[0-9]{2}/, /^VIOS .*/ # service pack
        items = model.find_all_by_service_pack(item_upcase, finder_options)
        
      when /^U[0-9][0-9][0-9][0-9][0-9][0-9]$/ # PTF
        items = model.find_all_by_ptf(item_upcase, finder_options)
      
      when /^([^ :]+)[ :]+([^ :]+)$/ # Fileset name with vrmf
        lpp, vrmf = item.split(/[ :]+/)
        items = model.find_all_by_lpp(lpp, finder_options.merge(conditions: [ 'vrmf LIKE ?', "#{vrmf}%"]))

      else                        # Just a fileset name
        items = model.find_all_by_lpp(item, finder_options)
      end
      rc = cache.write(dalli_params, items) # Need to do something with rc
    end
    return items
  end

  # Returns hash to be used for db search.  sort_order is a comma separate
  # list of columns.  Each can be preceded with a + or -.  + for
  # ascending (the default) and - for descending
  COLUMN_REGEXP = Regexp.new("([-+])?(.*)")
  def order(sort_order)
    valid_columns = model.columns.map{ |c| c.name }
    list = []
    errors = []
    sort_order.split(/, */).each do |column_text|
      dir, column = COLUMN_REGEXP.match(column_text)[1 .. 2]
      if valid_columns.include?(column)
        dir = ((dir == "-") ? "DESC" : "ASC")
        list << "\"#{column}\" #{dir}"
      else
        errors << "invalid column #{column} in sort order -- ignored"
      end
    end
    [{ order: list.join(', ') }, errors]
  end
end
