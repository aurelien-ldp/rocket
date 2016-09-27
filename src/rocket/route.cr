module Rocket
  # Route class is here to store informations about a route.
  # A Route is defined by:
  # - an HTTP method
  # - an URL path
  # - a controller instance
  # - the action to call
  #
  class Route
    getter method, path, controller, action, param_names
    getter regex : Regex

    # Stores information and generate regex for the router to match the correct path.
    def initialize(@method : String, @path : String, @controller : Controller, @action : String)
      @param_names = [] of String
      path = path.gsub(/\/+/, "/")
      parse_param_names(path)
      @regex = generate_regex(path)
    end

    # Store the current context in the controller, extract parameters from it,
    # call the action then return the result.
    def call_action(context)
      p = extract_params(context)
      p.each_with_index { |p, i| @controller.params[@param_names[i]] = p }
      if context.request.query != nil
        query_params = {} of String => String | Nil
        t = context.request.query.as(String).split('&')
        t.each { |e|
          query_params[e.split('=')[0].as(String)] = e.split('=')[1]?
        }
        @controller.params.merge!(query_params)
      end
      @controller.context = context
      @controller.actions[@action].call
    end

    private def parse_param_names(path)
      path.split('/').map { |p| @param_names << p.delete(':') if p.starts_with?(':') }
    end

    private def extract_params(context)
      context.request.path.split('/') - @path.split('/')
    end

    private def generate_regex(path)
      return /^\/$/ if path == "/"
      path = path.chop if path[-1] == '/'
      path = path.insert(0, "^").insert(-1, "$")
      path = path.gsub("/", "\\/")
      Regex.new(path.gsub(/\\\/:.[^\\\/\$]*/, "(\/+).[^\/]+"))
    end
  end
end
