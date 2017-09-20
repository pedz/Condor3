# config valid only for current version of Capistrano
lock "3.8.1"

set :application, "condor3"
set :repo_url, "pedzan@tcp149.aus.stglabs.ibm.com:/gsa/ausgsa/home/p/e/pedzan/git.repositories/condor3.git"

# Default branch is :master
ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/home/condor/app-base"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", "config/secrets.yml"

# Default value for linked_dirs is []
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets"

# Default value for default_env is {}
# This is first to find the ruby version we want
# /gsa/ausgsa/projects/r/ruby/prvm/ruby-2.3.1/bin
# This is somewhere... so we find pg_config
# /gsa/ausgsa/projects/r/ruby/pgsql/bin
# This is so we hit our weird ld instead of the default ld
# /gsa/ausgsa/projects/r/ruby/hide-aixbin
# This is so we find git and all its friends
# /gsa/ausgsa/projects/r/ruby/bin
set :default_env, { path: "/gsa/ausgsa/projects/r/ruby/prvm/ruby-2.3.1/bin:/gsa/ausgsa/projects/r/ruby/pgsql/bin:/gsa/ausgsa/projects/r/ruby/hide-aixbin:/gsa/ausgsa/projects/r/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do
  namespace :assets do
    desc 'Run the precompile task locally and rsync with shared'
    task :precompile do
      sh "bundle exec rake assets:precompile"
      roles(:web).each do |host|
        user = host.user
        hostname = host.hostname
        sh "rsync -av public/assets #{user}@#{hostname}:#{release_path}/public"
      end
      sh "bundle exec rake assets:clean"
    end
  end
end
