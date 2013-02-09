#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 
require 'spec_helper'

describe SwinfosController do
  let(:model) { GetSwinfos }

  let(:presenter) { :swinfo }

  let(:item) { '12345' }

  let(:post_options) { { item: item } }

  let(:full_options) { post_options.merge(sort: ::SwinfosController::DEFAULT_SORT_ORDER, page: '1') }

  it_behaves_like "a controller"

  describe "GET" do
    it "should redirect if sort is not given" do
      get :show, item: item, page: '5'
      response.should redirect_to(action: 'show',
                                  item: item,
                                  sort: ::SwinfosController::DEFAULT_SORT_ORDER,
                                  page: '5')
    end

    it "should redirect if page is not given" do
      get :show, item: item, sort: 'cows, love, people'
      response.should redirect_to(action: 'show',
                                  item: item,
                                  sort: 'cows, love, people',
                                  page: '1')
    end
  end
end
