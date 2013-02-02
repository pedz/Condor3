#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 
module RSpec::CapybaraExtensions
  def rendered
    Capybara.string(@rendered)
  end

  def within(selector)
    yield rendered.find(selector)
  end
end
