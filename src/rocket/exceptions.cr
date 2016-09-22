# Rocket's custom exceptions
#
module Rocket::Exceptions
  # Related to `Router`. Raises when router cannot find a route matching the request
  #
  class RouteNotFound < Exception
    def initialize(context : HTTP::Server::Context)
      super "Route not found for request: #{context.request.method} #{context.request.path}"
    end
  end
end
