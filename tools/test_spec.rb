#
# I had a bug and I was trying to recreate it with this test.  The bug
# was that the error could not reach pretty_print.
#
require 'spec_helper'

class Driver
  def initialize(options)
    options[:depend].new(a: 1)
  end
end

describe Driver do
  let(:my_double) { double('oh_my') }

  let(:typical_options) { {
      depend: my_double,
      not_used: 1,
      blah: 2
    }
  }

  it "should print nicely" do
    my_double.should_receive(:new).once do |options|
      options.should include(a: 2)
    end
    Driver.new(typical_options)
  end
end
