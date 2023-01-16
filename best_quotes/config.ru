require './config/application'
require 'rack'

app = BestQuotes::Application.new

use Rack::ContentType

# routing table using RouteObject as self for the block
app.route do
  match "", "quotes#index"
  match "sub-app", proc {
    [200, {}, ["Hello sub app"]]
  }
  match ":controller/:id/:action"
  match ":controller/:id",
    :default => {"action" => "show"}
  match ":controller",
    :default => {"action" => "index"}
end

run app
