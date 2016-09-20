require "http"

module Rocket
  class Router < HTTP::Handler
    property routes
    property controllers

    def initialize()
      @routes = [] of Route
      @controllers = {} of String => Controller
    end

    def add_route(method : String, path : String, controller : Controller.class, action : String)
      if !controller_exists?(controller)
        @controllers[controller.name] = controller.new
      end
      @routes << Route.new method, path, @controllers[controller.name], action
    end

    def call(context : HTTP::Server::Context)
      found = false
      @routes.each do |route|
        if action_match?(route, context)
          text = call_action(route.controller, route.action)
          context.response.print(text)
          found = true
        end
      end
      raise Rocket::Exceptions::RouteNotFound.new(context) unless found
    end

    private def action_match?(route, context)
      route.path == context.request.path && route.method == context.request.method
    end

    private def controller_exists?(controller : Controller.class)
      @controllers[controller.name]? != nil
    end

    private def call_action(controller, action)
      controller.actions[action].call
    end
  end
end
