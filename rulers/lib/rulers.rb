require "rulers/version"
require "rulers/routing"
require 'rulers/util'
require 'rulers/dependencies'
require 'rulers/controller'
require 'rulers/file_model'

module Rulers
  class Application
    def call(env)
      puts env['PATH_INFO']
      if env['PATH_INFO'] == '/favicon.ico'
        return [404, {'content-type' => 'text/plain'},
          ['not found']]
      end


      rack_app = get_rack_app(env)
      rack_app.call(env)
    end
  end  
end
