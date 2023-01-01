require "rulers/version"
require "rulers/routing"

module Rulers
  class Application
    def call(env)
      puts env['PATH_INFO']
      if env['PATH_INFO'] == '/favicon.ico'
        return [404, {'content-type' => 'text/plain'},
          ['not found']]
      end


      # a, b = c() is a way of simulating multiple return values by returning an array
      klass, act = get_controller_and_action(env)
      controller = klass.new(env)
      text = controller.send(act)
      [200, {'content-type' => 'text/html'},
        [text]]
    end
  end
  
  class Controller
    def initialize(env)
      @env = env
    end

    def env
      @env
    end
  end
end
