require 'bundler/capistrano'
require 'rvm/capistrano'
require 'capistrano/foreman'
require 'puma/capistrano'

set :application, 'datingscene'
set :user, "deploy"

set :rails_env, "production"
set :app_env, "production"
set :branch, "master"

set :domain, "96.126.101.186"
role :app, domain
role :web, domain
role :db,  domain, :primary => true

set :scm, :git
set :repository, 'git@github.com:railsrumble/r13-team-179.git'
set :deploy_to, "/home/deploy/#{application}"
set :deploy_via, :remote_cache
set :normalize_asset_timestamps, false
set :use_sudo, false
set :branch, "master"
set :ssh_options, { :forward_agent => true }
default_run_options[:pty] = true
set :rvm_type, :system

set :keep_releases, 5

# Default settings
set :foreman_sudo, 'rvmsudo'                    # Set to `rvmsudo` if you're using RVM
set :foreman_upstart_path, '/etc/init/' # Set to `/etc/init/` if you don't have a sites folder
set :foreman_options, {
  app: application,
  log: "#{shared_path}/log",
  user: user
}


namespace :nginx do 
  
  %w( start stop ).each do |name|
  desc "#{name.capitalize} Nginx"
    task name.to_sym, :roles => :app do 
      run "/etc/init.d/nginx #{name}"
    end
  end
end


namespace :deploy do
  
    desc 'Move config/database.yml.staging to config/database.yml'
    task :set_database_yml, :except => { :no_release => true } do
      run "mv #{latest_release}/config/database.yml.sample #{latest_release}/config/database.yml"
    end
    
    task :start do
      nginx.start
    end
    
    task :stop do
      nginx.stop
    end
    
    task :restart do
      #run '/etc/init.d/nginx reload'
    end
  
end

after 'deploy:update_code', 'deploy:set_database_yml'
after "deploy:restart", "deploy:cleanup"
after 'deploy:update', 'foreman:export'
after "deploy:restart", "foreman:restart"
