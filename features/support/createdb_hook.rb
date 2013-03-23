#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 

# To use this, a feature needs to have the following tags
# @snapshot @no-database-cleaner
# The later turns off cucumber-rails' call to DatabaseCleaner.start
# and DatabaseCleaner.clean
#
# The code below is not used but I kept it just so I can remember how
# to do it.
Before('@createdb') do
  postgres_config = ActiveRecord::Base.configurations["postgres"]
  template_config = ActiveRecord::Base.configurations["template"]
  test_config = ActiveRecord::Base.configurations["test"]
    .merge("template" => template_config["database"])

  ActiveRecord::Base.establish_connection(postgres_config)
  ActiveRecord::Base.connection.recreate_database(test_config["database"], test_config)
  ActiveRecord::Base.connection.close
  ActiveRecord::Base.establish_connection(test_config)
  DatabaseCleaner.start
end

After('@createdb') do
  DatabaseCleaner.clean
end
