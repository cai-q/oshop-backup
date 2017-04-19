set :application, 'oshop'
set :repo_url, 'git@github.com:ronaldoooo/oshop.git'
ask :branch, 'master'

# in RAILS_ROOT/config/deploy.rb:
after 'deploy:updated', 'deploy:symlink_db'

namespace :deploy do
  desc "Symlinks the database.yml"
  task :symlink_db, :roles => :app do
    run "ln -nfs #{deploy_to}/shared/config/database.yml #{release_path}/config/database.yml"
  end
end