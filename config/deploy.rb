require 'bundler/capistrano'
#require 'capistrano-rbenv'

set :use_sudo, false
set :user, "web"

set :default_environment, {
  'PATH' => "$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH"
}

set :application, "kingarturius"
set :deploy_to, "/home/web/www/#{application}"
set :scm, :git
set :repository,  "git@github.com:Vachman/kingarturius.git"
set :rbenv_ruby_version, '1.9.3-p194' 

ssh_options[:keys] = %w('~/.ssh/id_rsa.pub')

role :web, "kingarturius.ru"                          # Your HTTP server, Apache/etc
role :app, "kingarturius.ru"                          # This may be the same as your `Web` server
role :db,  "kingarturius.ru", :primary => true # This is where Rails migrations will run


# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  desc "Create shared files and folders"
  task :create_shared do
    run "mkdir -p #{shared_path}/config"
    run "mkdir -p #{shared_path}/tmp"
    run "mkdir -p #{shared_path}/log"
    run "mkdir -p #{shared_path}/system"

    run "mkdir -p #{shared_path}/public/system"
    run "mkdir -p #{shared_path}/public/files"
    run "mkdir -p #{shared_path}/public/ckeditor_assets"

    put '', "#{shared_path}/config/database.yml"
    put '', "#{shared_path}/log/development.log"
    put '', "#{shared_path}/log/production.log"
  end

  desc "Create links to database.yml, tmp and system"                 
  task :finalize_update do                                            
    run "ln -nfs #{shared_path}/log/development.log #{release_path}/log/development.log"
    run "ln -nfs #{shared_path}/log/production.log #{release_path}/log/production.log"

    run "ln -nfs #{shared_path}/system #{release_path}/public/system"
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/tmp #{release_path}/tmp"

    run "ln -nfs #{shared_path}/public/system #{release_path}/public/system"
    run "ln -nfs #{shared_path}/public/files #{release_path}/public/files"
    run "ln -nfs #{shared_path}/public/ckeditor_assets #{release_path}/public/ckeditor_assets"
  end

  desc 'Runs rake db:migrate'
  task :apply_migrations, :roles => :db do
    run "cd #{release_path} && RAILS_ENV=production bundle exec rake db:migrate"
  end
  
  
  after 'deploy', 'deploy:cleanup'
end
after 'deploy:setup', 'deploy:create_shared'
after 'deploy', 'deploy:apply_migrations'


#set :bundle_flags, "--deployment --quiet --shebang ruby-local-exec"
#set (:bundle_cmd) { "/home/web/.rbenv/versions/1.9.3-p194/bin/bundle" }
#set :rake, '/home/web/.rbenv/versions/1.9.3-p194/bin/rake'

