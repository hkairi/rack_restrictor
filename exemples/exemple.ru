require 'rubygems'
require 'rack_restrictor'

class MonApp
  def call(env)
    [ 200, {"Content-Type"=>"text/plain"}, "Hello World"]
  end
end

use Rack::Restrictor, "127.0.0.1/24"
run MonApp.new