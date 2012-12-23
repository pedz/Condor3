require 'spec_helper'

describe SwinfoPresenter do
  subject { SwinfoPresenter.new(view, double('swinfo')) }

  it_behaves_like "a presenter"
end
