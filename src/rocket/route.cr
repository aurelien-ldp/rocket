module Rocket
  # Route class is here to store informations about a route.
  # A Route is defined by:
  # - an HTTP method
  # - an URL path
  # - a controller instance
  # - the action to call
  #
  class Route
    getter method, path, controller, action

    def initialize(@method : String, @path : String, @controller : Controller, @action : String)
    end

    # Store the current context in the controller, call the action
    # then return the result.
    def call_action(context)
      @controller.context = context
      @controller.actions[@action].call
    end
  end
end
