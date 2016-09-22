require "http"

module Rocket
  # Is responsible for definning routes, instantiating controllers and
  # routing incoming context from the server to the corresponding
  # controller's action.
  # Acts as a middleware (see: [HTTP::Handler](https://crystal-lang.org/api/0.19.2/HTTP/Handler.html))
  #
  # Adding a route:
  # ```
  # router = Rocket::Router.new
  #
  # router.add_route("GET", "/", WelcomeController, "index")
  # router.add_route("POST", "/users", UsersController, "create")
  # ```
  #
  # Assuming `WelcomeController` and `UsersController` inherit from
  # `Rocket::Controller`.
  #
  # The instance is composed of an array of `Rocket::Route` which stores
  # all the routes added by `#add_route`
  # and a Hash which stores the name of the controller's class and an
  # instance of it.
  #
  class Router < HTTP::Handler
    def initialize
      @routes = [] of Route
      @controllers = {} of String => Controller
    end

    # Creates a route based on the HTTP *method*, the URL *path* to be matched,
    # the instantiated *controller* and the *controller*'s action to call.
    def add_route(method : String, path : String, controller : Controller.class, action : String)
      if !controller_exists?(controller)
        @controllers[controller.name] = controller.new
      end
      @routes << Route.new method, path, @controllers[controller.name], action
    end

    # As a middleware, it is called by the server with a *context*
    # If the request matches with a route it performs
    # a routing by calling the correct controller's action and printing the
    # result into the response. If no routes matches, raises
    # `Exceptions::RouteNotFound`.
    def call(context : HTTP::Server::Context)
      found = false
      @routes.each do |route|
        if action_match?(route, context)
          text = route.call_action(context)
          context.response.print(text)
          found = true
        end
      end
      raise Rocket::Exceptions::RouteNotFound.new(context) unless found
    end

    private def action_match?(route, context)
      route.method == context.request.method && route.path == context.request.path
    end

    private def controller_exists?(controller : Controller.class)
      @controllers[controller.name]? != nil
    end
  end
end
