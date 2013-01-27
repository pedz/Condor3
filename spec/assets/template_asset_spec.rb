require 'spec_helper'

# After much work, this turned out to not be much...
# We need to remove tmp/cache before running this test.
# http://stackoverflow.com/questions/14188937/force-sprockets-to-compile-asset-during-test
describe Sprockets::JSRender::Processor do
  # For now, just delete it from here.  I'm worried since the delete
  # comes after the application starts that it might already have some
  # assets cached up...
  before(:each) do
    (Rails.root + "tmp/cache").rmtree
  end
  
  it "should parse the application digest" do
    visit '/assets/application.js'
    # puts source
    source.should match('\$.templates\({"upd_apar_def_row": "')
  end
end
