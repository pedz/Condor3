require "bundler/capistrano"

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

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
