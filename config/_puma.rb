environment ENV['RACK_ENV']
threads 8,32
workers 3
preload_app!

on_worker_boot do
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::Base.establish_connection
  end
end

before_fork do
  ActiveRecord::Base.connection_pool.disconnect!
end

lowlevel_error_handler do |e|
  Rollbar.critical(e)
  [500, {}, ["An error has occurred, and engineers have been informed. Please reload the page. If you continue to have problems, contact contacto@01luisrene.com\n"]]
end