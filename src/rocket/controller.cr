module Rocket
  # A controller defines actions. When called these actions execute
  # the logic and return text to render through the response.
  #
  abstract class Controller
    property actions, context

    # The macro stores actions as a `Proc` in a Hash
    # so that `actions['action_name'].call` executes the action.
    def initialize
      @actions = {} of String => -> String
      @context = uninitialized HTTP::Server::Context

      {% for action in @type.methods %}
        @actions[{{action.name.stringify}}] = ->self.{{action.name}}
      {% end %}
    end

    # Returns true if the actions has been defined in the controller,
    # false otherwise.
    def action_exists?(action_name)
      @actions.each { |a| a[0] == action_name ? return true : next }
      false
    end
  end
end
