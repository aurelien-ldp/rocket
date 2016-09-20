module Rocket::Exceptions
  class RouteNotFound < Exception
    def initialize(context : HTTP::Server::Context)
      super "Route not found for path: #{context.request.path}"
    end
  end
end
