require "http"

module Rocket
  # Handles the custom exceptions and return an appropriate response
  #
  class ErrorHandler
    include HTTP::Handler

    def call(context)
      begin
        call_next(context)
      rescue route_not_found_ex : Exceptions::RouteNotFound
        context.response.respond_with_error("Route not Found", 404)
      rescue ex : Exception
        context.response.respond_with_error
      end
    end
  end
end
