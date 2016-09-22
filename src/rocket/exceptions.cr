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

  # Raises when the action specified in the route doesn't match any
  # actions of the controller.
  #
  class ActionNotFound < Exception
    def initialize(controller, action)
      super "Action not found: #{controller}##{action}"
    end
  end
end
