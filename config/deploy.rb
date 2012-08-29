require "bundler/capistrano"
load 'deploy/assets'

set :default_shell, "bash -l"

set :application, "condor3"
set :repository,  "ssh://condor@condor.austin.ibm.com/~/app-base/condor3.git"
set :deploy_to, "~/app-base"

set :scm, :git
set :user, "condor"

role :web, "condor.austin.ibm.com"                         # Your HTTP server, Apache/etc
role :app, "condor.austin.ibm.com"                         # This may be the same as your `Web` server
role :db,  "condor.austin.ibm.com", :primary => true       # This is where Rails migrations will run

set :branch, "master"
set :deploy_via, :remote_cache
set :git_enable_submodules, 1
set :use_sudo, false

# Don't need asset gems on production server
set :bundle_without,  [:development, :test, :assets]

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  desc "No way to start the server"
  task :start do ; end
  desc "No way to stop the server"
  task :stop do ; end
  desc "Restart the server"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

namespace :deploy do
  namespace :assets do
    desc 'Run the precompile task locally and rsync with shared'
    task :precompile, :roles => :web, :except => { :no_release => true } do
      %x{bundle exec rake assets:precompile}
      %x{rsync --recursive --times --rsh=ssh --compress --human-readable --progress public/assets #{user}@#{host}:#{shared_path}}
      %x{bundle exec rake assets:clean}
    end
  end
end
