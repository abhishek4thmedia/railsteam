# Your Applications "Name"
set :application, "railsteamnew"
#set :domain, "mckworld.com"
set :domain, "staging.railsteam.com"

# The URL to your applications repository

set :repository,  "https://svn.codespaces.com/4thmedia/railsteamnew/trunk/"
set :scm_username, "hrishikesh"
set :scm_password, "fourthmedia"

#ssh_options[:paranoid] = false

# Uncomment this line if you're using SVN.  It makes deployments much faster
set :deploy_via, :remote_cache

# Require subversion to do an export instead of a checkout.
set :checkout, 'export'

# The user you are using to deploy with (This user should have SSH access to your server)
set :user, "root"
set :password, "dVf27378"

# We want to deploy everything under your user, and we don't want to use sudo
set :use_sudo, false

# Where to deploy your application to.
set :deploy_to, "/home/var/www/rails/railsteamnew/"
set :deploy_via, :checkout
# -------------------------------- Server Definitions --------------------------------
# Define the hostname of your server.  If you have multiple servers for multiple purposes, we can define those below as well.
set :server_name, "74.50.51.222"

# We're assuming you're using a single server for your site, but if you have a seperate asset server or database server, you can specify that here.
role :app, server_name
role :web, server_name
role :db,  server_name, :primary => true

set :rails_env, :production
# -------------------------------- Final Config --------------------------------
# This configuration option is helpful when using svn+ssh but doesn't hurt anything to leave it enabled always.
default_run_options[:pty] = false

desc "Fix permissions on deployed version"
task :before_restart, :roles => :web do
	sudo "chown -R root:root #{deploy_to}current/public"
	sudo "chmod -R 777 #{deploy_to}current/public"
        
	sudo "chown -R root:root #{deploy_to}current/public"
	sudo "chmod -R 777 #{deploy_to}current/vendor/extensions/mediamaid/public"
#	sudo "chmod -R 777 #{deploy_to}current/vendor/extensions/mediamaid/public"

	sudo "chown -R root:root #{deploy_to}current/tmp"
	run "chmod 777 #{deploy_to}current/tmp"

	sudo "chown -R root:root #{deploy_to}current/tmp/cache"
	run "chmod 777 #{deploy_to}current/tmp/cache"
  
	sudo "chown -R root:root #{deploy_to}current/tmp/cache/entity"
	run "chmod 777 #{deploy_to}current/tmp/cache/entity"
  
	sudo "chown -R root:root #{deploy_to}current/tmp/cache/meta"
	run "chmod 777 #{deploy_to}current/tmp/cache/meta"
  
	sudo "chown -R root:root #{deploy_to}current/tmp/radiant_config_cache.txt"
	run "chmod 777 #{deploy_to}current/tmp/radiant_config_cache.txt"
        
	sudo "chown -R root:root #{deploy_to}current/log"
	run "chmod 777 #{deploy_to}current/log"
        
	sudo "chown -R root:root #{deploy_to}shared/log"
	run "chmod 777 #{deploy_to}shared/log"

	sudo "chown -R root:root #{deploy_to}current"
	run "chmod 777 #{deploy_to}current"

  run "ln -s /home/var/www/rails/railsteamnew/assets/ assets"

end


namespace :deploy do
  task :restart do
    run "touch #{deploy_to}/current/tmp/restart.txt"
  end

  task :start do
    run "touch #{deploy_to}/current/tmp/restart.txt"
  end
end




#set :application, "set your application name here"
#set :repository,  "set your repository location here"
#
#set :scm, :subversion
## Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
#
#role :web, "your web-server here"                          # Your HTTP server, Apache/etc
#role :app, "your app-server here"                          # This may be the same as your `Web` server
#role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"
#
## If you are using Passenger mod_rails uncomment this:
## if you're still using the script/reapear helper you will need
## these http://github.com/rails/irs_process_scripts
#
## namespace :deploy do
##   task :start do ; end
##   task :stop do ; end
##   task :restart, :roles => :app, :except => { :no_release => true } do
##     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
##   end
## end