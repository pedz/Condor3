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
    expect(sd.old_seq.length).to eq(8)
    expect(sd.old_seq[1][0]).to eq("discard_a")
    expect(sd.new_seq.length).to eq(7)
    expect(sd.new_seq[6][0]).to eq("change")
    expect(sd.diff_count).to eq(3)
  end
end
