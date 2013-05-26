#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 

# To use this, a feature needs to have the following tags @snapshot
# @no-database-cleaner The later turns off cucumber-rails' call to
# DatabaseCleaner.start and DatabaseCleaner.clean
Before('@snapshot') do
  DatabaseState.instance.get_to_state(:template) do 
    system('/usr/local/pgsql/bin/pg_restore -U postgres --clean --single-transaction ' +
           '--dbname=condor3_test /Users/pedzan/Source/Rails3/condor3/features/support/template-smaller.db')

    # Not 100% sure why this is needed but if it isn't here, the 2nd
    # time the restore is done, the app can no longer find anything in
    # the database (including the tables, etc).
    test_config = ActiveRecord::Base.configurations["test"]
    ActiveRecord::Base.connection.close
    ActiveRecord::Base.establish_connection(test_config)
  end
  DatabaseCleaner.start
end

After('@snapshot') do
  DatabaseCleaner.clean
end

# To use this, a feature needs to have the following tags
# @empty_db @no-database-cleaner
Before('@empty_db') do
  DatabaseState.instance.get_to_state(:empty) do 
    DatabaseCleaner.clean_with(:deletion)
  end
  DatabaseCleaner.start
end

After('@empty_db') do
  DatabaseCleaner.clean
end

# You want this hook at the very end so it gets the value of the
# strategy that was used
Before do
  DatabaseState.instance.record_strategy
end
