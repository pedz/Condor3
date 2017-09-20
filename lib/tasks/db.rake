
namespace :db do
  desc "Restore condor's database from a specified file"
  task :restore, [:filename] => :load_config do |t, args|
    raise "task restore: filename expected" unless !args.filename.blank?
    config = ActiveRecord::Base.configurations[RAILS_ENV]
    sh "pg_restore -l #{args.filename} | egrep -v ' ((TABLE|SEQUENCE) .* (cmvcs|users)|SCHEMA )' > /tmp/db.list"
    sh "pg_restore -U #{config["username"]} --clean --no-owner -L /tmp/db.list --single-transaction --dbname=#{config["database"]} #{args.filename}"
  end

  desc "Dump condor's database to a specified file but excludes the user and cmvc tables"
  task :dump, [:filename] => :load_config do |t, args|
    raise "task dump: filename expected" unless !args.filename.blank?
    config = ActiveRecord::Base.configurations[RAILS_ENV]
    sh "pg_dump -U #{config["username"]} --file=#{args.filename} --format=custom #{config["database"]}"
  end
end
