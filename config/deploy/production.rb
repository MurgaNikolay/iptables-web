server 'qa1.vocvox.com', user: 'deploy', roles: %w{web app}

set :rails_env, 'production'
set :unicorn_rack_env, 'production'
set :deploy_to, '/var/www/access'
set :unicorn_pid, '/var/www/access/shared/tmp/pids/unicorn.pid'
