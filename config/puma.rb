environment ENV['RACK_ENV'] || 'development'
port        ENV['PORT']     || 3000
threads 0,5

workers 3
preload_app!

on_worker_boot do
	ActiveSupport.on_load(:active_record) do
		ActiveRecord::Base.establish_connection
	end
end