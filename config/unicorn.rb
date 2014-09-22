# set path to app that will be used to configure unicorn,
# note the trailing slash in this example
dir = File.realpath(File.join(File.dirname(__FILE__), '..'))

worker_processes 2
working_directory dir

timeout 30

# Specify path to socket unicorn listens to,
# we will use this in our nginx.conf later
#listen '127.0.0.1:3008'
listen "#{dir}/tmp/sockets/unicorn.socket", :backlog => 64

# Set process id path
pid "#{dir}/tmp/pids/unicorn.pid"
old_pid = "#{dir}/tmp/pids/unicorn.oldpid"
# Set log file paths
stderr_path "#{dir}/log/unicorn.stderr.log"
stdout_path "#{dir}/log/unicorn.stdout.log"


before_fork do |server, worker|
  server.logger.info("worker=#{worker.nr} spawning in #{Dir.pwd}")
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill('QUIT', File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end
  Signal.trap 'TERM' do
    server.logger.info 'Unicorn master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  Signal.trap 'TERM' do
    server.logger.info 'Unicorn worker intercepting TERM and doing nothing. Wait for master to send QUIT'
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end
