require 'erubis'
require 'rack/request'
require 'rack/response'
require 'rulers/file_model'

module Rulers
  # base class for all controllers
  # ensures that they're all initialized with a Rake env
  class Controller
    include Rulers::Model # makes FileModel available in the controllers

    def initialize(env)
      @env = env
    end

    def env
      @env
    end

    def request
      @request ||= Rack::Request.new(@env)
    end

    def response(text, status = 200, headers = {})
      raise "Already responded!" if @response
      response_text = [text].flatten
      @response = Rack::Response.new(response_text, status, headers)
    end

    def get_response
      @response
    end

    def params
      request.params # this call is the same as self.request().params
    end

    def render_response(*args) # *args in definition - rest
      response(render(*args)) # *args in method call - spread
    end

    def render(view_name, locals = {})
      filename = File.join('app', 'views', controller_name(), "#{view_name}.html.erb")
      template = File.read filename
      eruby = Erubis::Eruby.new(template)
      eruby.result(locals.merge(:env => env))
    end

    def controller_name
      klass = self.class
      klass = klass.to_s.gsub(/Controller$/, '')
      Rulers.to_underscore(klass)
    end
  end
end
