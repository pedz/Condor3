# -*- coding: utf-8 -*-
#
# Copyright 2013 Ease Software, Inc.
# All Rights Reserved
#
require 'spec_helper'

FauxColumn = Struct.new(:name)

describe Swinfo do
  let(:local_cache) {
    double('local_cache').tap do |d|
      d.stub(:read) { nil }
      d.stub(:write) { true }
    end
  }

  let(:local_model) {
    double('local_model').tap do |d|
      d.stub(:columns) {[
                         FauxColumn.new('col_a'),
                         FauxColumn.new('col_b'),
                         FauxColumn.new('col_c'),
                         FauxColumn.new('col_d'),
                         FauxColumn.new('col_e'),
                         FauxColumn.new('col_f'),
                         FauxColumn.new('col_g'),
                         FauxColumn.new('col_h')
                        ]}
    end
  }

  let(:typical_options) { {
      cache: local_cache,
      model: local_model,
      page: '1',
      sort: 'col_a, col_b, col_c'
    } }

  let(:typical_search_options) { {
      order: "\"col_a\" ASC, \"col_b\" ASC, \"col_c\" ASC",
      limit: 1000
    } }

  it "should search for a defect when a defect name is supplied" do
    item = '12345'
    local_model.should_receive(:find_all_by_defect).with(item, typical_search_options)
    swinfo = Swinfo.new(typical_options.merge(item: item))
    swinfo.errors.should be_empty
    swinfo.item.should eq(item)
  end

  it "should search for an APAR when an APAR name is supplied" do
    item = 'IV12345'
    local_model.should_receive(:find_all_by_apar).with(item, typical_search_options)
    swinfo = Swinfo.new(typical_options.merge(item: item))
    swinfo.errors.should be_empty
    swinfo.item.should eq(item)
  end

  it "should search for a CQ Defect when a CQ Defect name is supplied" do
    item = 'XP123456'
    local_model.should_receive(:find_all_by_cq_defect).with(item, typical_search_options)
    swinfo = Swinfo.new(typical_options.merge(item: item))
    swinfo.errors.should be_empty
    swinfo.item.should eq(item)
  end

  it "should search for a VIOS Service Pack when a VIOS Service Pack name is supplied" do
    item = 'VIOS 2.2.1.2'
    local_model.should_receive(:find_all_by_service_pack).with(item, typical_search_options)
    swinfo = Swinfo.new(typical_options.merge(item: item))
    swinfo.errors.should be_empty
    swinfo.item.should eq(item)
  end

  it "should search for a PTF when a PTF name is supplied" do
    item = 'U123456'
    local_model.should_receive(:find_all_by_ptf).with(item, typical_search_options)
    swinfo = Swinfo.new(typical_options.merge(item: item))
    swinfo.errors.should be_empty
    swinfo.item.should eq(item)
  end

  it "should search for a fileset when a fileset name is supplied" do
    item = 'bos.mp64'
    local_model.should_receive(:find_all_by_lpp).with(item, typical_search_options)
    swinfo = Swinfo.new(typical_options.merge(item: item))
    swinfo.errors.should be_empty
    swinfo.item.should eq(item)
  end

  it "should search for a fileset with vrmf when a fileset name and vrmf is supplied" do
    item = 'bos.mp64 6.1.4.3'
    local_model.should_receive(:find_all_by_lpp).
      with('bos.mp64', typical_search_options.merge(conditions: ["vrmf LIKE ?", "6.1.4.3%"]))
    swinfo = Swinfo.new(typical_options.merge(item: item))
    swinfo.errors.should be_empty
    swinfo.item.should eq(item)
  end

  it "should ignore columns not in the model" do
    item = '12345'
    local_model.should_receive(:find_all_by_defect).
      with(item, typical_search_options.merge(order: "\"col_b\" ASC, \"col_c\" ASC"))
    swinfo = Swinfo.new(typical_options.merge(item: item, sort: 'col_x, col_b, col_c'))
    swinfo.errors.should have(1).item
    swinfo.errors[0].should match(/invalid column col_x/)
    swinfo.item.should eq(item)
  end

  it "should search decending when specified" do
    item = '12345'
    local_model.should_receive(:find_all_by_defect).
      with(item, typical_search_options.merge(order: "\"col_a\" DESC, \"col_b\" ASC, \"col_c\" ASC"))
    swinfo = Swinfo.new(typical_options.merge(item: item, sort: '-col_a, col_b, col_c'))
    swinfo.errors.should be_empty
    swinfo.item.should eq(item)
  end

  it "should start at offset 2000 when page is equal to 2" do
    item = '12345'
    local_model.should_receive(:find_all_by_defect).
      with(item, typical_search_options.merge(offset: 1000))
    swinfo = Swinfo.new(typical_options.merge(item: item, page: '2'))
    swinfo.errors.should be_empty
    swinfo.item.should eq(item)
  end

  it "should remove the limit with page is set to 'all'" do
    item = '12345'
    temp = typical_search_options.dup
    temp.delete(:limit)
    local_model.should_receive(:find_all_by_defect).with(item, temp)
    swinfo = Swinfo.new(typical_options.merge(item: item, page: 'all'))
    swinfo.errors.should be_empty
    swinfo.item.should eq(item)
  end

  it "should call cache's read method and return what it returns" do
    item = '12345'
    cached_result = [ 1, 2, 3 ]
    local_cache.stub(:read) do |arg|
      arg.should be_a(Hash)
      arg.should eq({order: "\"col_a\" ASC, \"col_b\" ASC, \"col_c\" ASC", limit: 1000, item: "12345"})
      cached_result
    end
    swinfo = Swinfo.new(typical_options.merge(item: item))
    swinfo.errors.should be_empty
    swinfo.item.should eq(item)
    swinfo.upd_apar_defs.should eq(cached_result)
  end

  it "should call cache's write method with the results of the find" do
    item = '12345'
    cached_result = [ 1, 2, 3 ]
    local_cache.stub(:write) do |arg, result|
      arg.should be_a(Hash)
      arg.should eq({order: "\"col_a\" ASC, \"col_b\" ASC, \"col_c\" ASC", limit: 1000, item: "12345"})
      result.should eq(cached_result)
      true
    end
    local_model.stub(:find_all_by_defect) { cached_result }
    swinfo = Swinfo.new(typical_options.merge(item: item))
    swinfo.errors.should be_empty
    swinfo.item.should eq(item)
    swinfo.upd_apar_defs.should eq(cached_result)
  end
end
