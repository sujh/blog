# config valid for current version and patch releases of Capistrano
lock "~> 3.11.1"

set :application, "my_blog"
set :repo_url, "https://github.com/sujh/blog.git"
set :keep_releases, 5
set :keep_assets, 2
# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"
set :deploy_to, -> { "~/deploy/#{fetch :application}" }
set :log_level, :debug
set :rvm_type, :user
set :rvm_ruby_version, '2.4.2@rails5.2'
ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true
set :puma_init_active_record, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml"
append :linked_files, "config/database.yml", "config/master.key", "config/credentials.yml.enc", ".env"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
