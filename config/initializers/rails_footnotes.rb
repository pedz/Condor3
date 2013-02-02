#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 
if defined?(Footnotes) && Rails.env.development?
  Footnotes.run! # first of all

  # ... other init code
end
