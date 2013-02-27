# -*- coding: utf-8 -*-
#
# Copyright 2013 Ease Software, Inc.
# All Rights Reserved
#
require 'spec_helper'

describe GetCmvcFromUser do
  it_should_behave_like "a get_cmvc_from_user" do
    let(:get_cmvc_from_user) { GetCmvcFromUser.new }
  end
end
