namespace :deploy do
  desc "Symlinks the database.yml"
  task :symlink_db do
    on roles :app do
      run "ln -nfs #{deploy_to}/shared/config/database.yml #{release_path}/config/database.yml"
      puts 'finished'
    end
  end
end