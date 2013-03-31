# -*- coding: utf-8 -*-
#
# Copyright 2013 Ease Software, Inc.
# All Rights Reserved
#
require 'spec_helper'

describe SrcFileDiff do
  let(:old_file) { [
                    "Line 1",
                    "Line 2",
                    "Line 3",
                    "Line 4",
                    "Line 5",
                    "Line 6",
                    "Line 7"
                   ]}

  let(:new_file) { [
                    "Line 1",
                    "Line 4",
                    "Line 5",
                    "Line 8",
                    "Line 6",
                    "Line 7 new"
                   ]}

  it "should report back the old and new sequences" do
    sd = SrcFileDiff.new(old_file, new_file)
    sd.old_seq.length.should eq(8)
    sd.old_seq[1][0].should eq("discard_a")
    sd.new_seq.length.should eq(7)
    sd.new_seq[6][0].should eq("change")
    sd.diff_count.should eq(3)
  end
end
