require "bundler/capistrano"

# I don't want this anymore
# load 'deploy/assets'

set :default_shell, "bash -l"

set :application, "condor3"
set :repository,  "ssh://condor@condor.austin.ibm.com/home/condor/app-base/condor3.git"
set :deploy_to, "/home/condor/app-base"

set :scm, :git
# set :user, "condor"

role :web, "condor@condor.austin.ibm.com"                         # Your HTTP server, Apache/etc
role :app, "condor@condor.austin.ibm.com"                         # This may be the same as your `Web` server
role :db,  "condor@condor.austin.ibm.com", :primary => true       # This is where Rails migrations will run

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

# namespace :deploy do
#   namespace :assets do
#     desc 'Run the precompile task locally and rsync with shared'
#     task :precompile, :roles => :web, :except => { :no_release => true } do
#       # %x{bundle exec rake assets:precompile}
#       # %x{rsync --recursive --times --rsh=ssh --compress --human-readable --progress public/assets #{user}@#{host}:#{shared_path}}
#       # %x{bundle exec rake assets:clean}
#       begin
#         run_locally "true"
#       ensure
#         logger.debug "banana"
#       end
#     end
#   end
# end

set :compressed_assets_path, "tmp/assets.tar.gz"

namespace :pedz do
  desc "Just a simple task to dump out the values of variables"
  task :vars do
    logger.debug("source=#{source}")
    logger.debug("current_revision=#{current_revision}")
    logger.debug("from=#{source.next_revision(current_revision)}")
  end

  namespace :local do
    # Note that it appears cap does a cwd to the directory where the
    # Capfile is found.
    namespace :assets do
      desc <<-DESC
        Clean the local precompiled assets
      DESC
      task :clean do
        run_locally("bundle exec rake assets:clean")
      end

      desc <<-DESC
        Clean the local compressed assets
      DESC
      task :clean_compress do
        run_locally("rm -f #{compressed_assets_path}")
      end

      desc <<-DESC
        Precompile the assets on the local system
      DESC
      task :precompile do 
        run_locally("bundle exec rake assets:precompile")
      end

      desc <<-DESC
        Create assets into #{compressed_assets_path}
      DESC
      task :compress, :roles => :app do
        transaction do
          # We want to make sure public/assets is not left around.
          on_rollback { clean_compress }
          begin
            clean
            precompile
            run_locally("tar cf - public/assets | gzip -9 > #{compressed_assets_path}")
          rescue => e
            logger.debug "rescue #{e.class}"
            raise e
          ensure
            # Can not leave precompiled assets in public/assets
            clean
          end
        end
      end
    end
  end

  namespace :deploy do
    desc <<-DESC
      Upload the assets after compiling them locally to the servers
      into the current_path.
    DESC
    task :upload_assets do
      pedz.local.assets.compress
      path = File.join(current_path, compressed_assets_path)
      run("rm -f #{path}")
      top.upload(compressed_assets_path, path)
      run("cd #{current_path} && tar xzf #{compressed_assets_path}")
    end

    desc <<-DESC
      Updates the assets after compiling them locally to the servers
      into the release_path
    DESC
    task :update_assets do
      pedz.local.assets.compress
      path = File.join(release_path, compressed_assets_path)
      run("rm -f #{path}")
      top.upload(compressed_assets_path, path)
      run("cd #{release_path} && tar xzf #{compressed_assets_path}")
    end
  end
end

after "deploy:update_code", "pedz:deploy:update_assets"
