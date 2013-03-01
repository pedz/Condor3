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

# variable cmvc_host is passed in
shared_examples_for "a cmvc_host" do
  it_should_behave_like "a cmd_result duck type" do
    let(:cmd_result) { cmvc_host }
  end
end

# variable execute_cmvc_command is pass in
shared_examples_for "an execute_cmvc_command" do
  it_should_behave_like "a cmd_result duck type" do
    let(:cmd_result) { execute_cmvc_command }
  end
end

# variable user is passed in
shared_examples_for "a user duck type" do
  describe "a user" do
    it "should respond to cmvc_login" do
      user.should respond_to(:cmvc_login)
    end

    it "should return a string when cmvc_login is called" do
      user.cmvc_login.should be_a(String)
    end
  end
end

# variable get_user is passed in
shared_examples_for "a get_user proc" do
  describe "a get_user proc" do
    it "should respond to `call'" do
      get_user.should respond_to(:call)
    end

    describe "when called should produce a valid user duck type" do
      it_should_behave_like "a user duck type" do
        let(:user) { get_user.call }
      end
    end
  end
end
