#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 

# variable cmd_result is passed in
shared_examples_for "a cmd_result duck type" do
  describe "cmd_result API" do
    it "implements the API" do
      cmd_result.should respond_to(:stdout)
      cmd_result.should respond_to(:stderr)
      cmd_result.should respond_to(:rc)
      cmd_result.should respond_to(:signal)
    end
  end
end

# variable get_cmvc_from_user is passed in
shared_examples_for "a get_cmvc_from_user" do
  it_should_behave_like "a cmd_result duck type" do
    let(:cmd_result) { get_cmvc_from_user }
  end
end
