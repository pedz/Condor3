require 'spec_helper'

# After much work, this turned out to not be much...
# We need to remove tmp/cache before running this test.
# http://stackoverflow.com/questions/14188937/force-sprockets-to-compile-asset-during-test
describe Sprockets::JSRender::Processor do
  it "should parse the application digest" do
    visit '/assets/application.js'
    # puts source
    source.should match('\$.templates\({"upd_apar_def_row": "')
  end
end
