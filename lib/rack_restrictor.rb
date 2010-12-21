require 'ipaddr'
module Rack
  class Restrictor
		PAGE_CODE = <<-EOCODE
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
	<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
		<head>
			<title> Anauthorized access</title>
		</head>
		<body>
			<h1> Anauthorized access</h1>
		</body>
	</html>
EOCODE

	def initialize(app, plage)
		@app   = app
    @plage = IPAddr.new( plage.to_s )    
	end

	def call(env)
		if authorized?( env['REMOTE_ADDR'].to_s )
			status, headers, body = @app.call(env)
		else
			status, headers, body = 
			401, {"Content-Type" => "text/html"}, PAGE_CODE
		end

		[status, headers, body]
	end

	private

	def authorized?( ip )
		@plage.include?(IPAddr.new( ip ))
  end
  
	end
end