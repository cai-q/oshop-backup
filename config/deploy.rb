set :application, 'oshop'
set :repo_url, 'git@github.com:ronaldoooo/oshop.git'
ask :branch, 'master'

# in RAILS_ROOT/config/deploy.rb:
before 'bundler:install', 'deploy:symlink_db'