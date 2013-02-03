#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 
# Note... to use this, you need to tag your Scenario or Feature with
# both @javascript and @webkit.  e.g.
#  @javascript @webkit
#  Scenario: ...
# and the order is important.  You want the javascript hooks done
# first.

Before('@webkit') do
  Capybara.current_driver = :webkit
end
