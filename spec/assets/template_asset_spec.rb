require 'spec_helper'

# After much work, this turned out to not be much...
describe Sprockets::JSRender::Processor do
  it "should parse the application digest" do
    visit '/assets/application.js'
    # puts source
    source.should match('\$.templates\({"upd_apar_def_row": "')
  end
end
