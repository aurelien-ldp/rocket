module Rocket
  # A controller defines actions. When called these actions execute
  # the logic and return text to render through the response.
  # A controller has a Hash of params which give access to all the params
  # defined in the route and the query params.
  #
  abstract class Controller
    property :actions, :params, :context

    # The macro stores actions as a `Proc` in a Hash
    # so that `actions['action_name'].call` executes the action.
    def initialize
      @actions = {} of String => -> String
      @params = {} of String => String | Nil

      empty_request = HTTP::Request.new("", "")
      empty_response = HTTP::Server::Response.new(IO::Memory.new)
      @context = HTTP::Server::Context.new(empty_request, empty_response)

      {% for action in @type.methods %}
        @actions[{{action.name.stringify}}] = ->self.{{action.name}}
      {% end %}
    end

    # Returns true if the action with *action_name* has been defined in
    # the controller, false otherwise.
    def action_exists?(action_name)
      @actions.each { |a| a[0] == action_name ? return true : next }
      false
    end
  end
end
