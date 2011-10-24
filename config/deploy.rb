set :application, "pin"
set :repository,  "git@github.com:spanner/pin.git"

set :scm, :git
set :git_enable_submodules, 1
set :ssh_options, { :forward_agent => true }
set :deploy_to, "/var/www/#{application}"
set :deploy_via, :remote_cache
default_run_options[:pty] = true

set :user, 'spanner'
set :group, 'spanner'
set :branch, 'master'

role :web, "seagoon.spanner.org"                          # Your HTTP server, Apache/etc
role :app, "seagoon.spanner.org"                          # This may be the same as your `Web` server
role :db,  "data.spanner.org", :primary => true           # This is where Rails migrations will run
# role :db,  "your slave db-server here"

after "deploy:update", "deploy:cleanup"

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end