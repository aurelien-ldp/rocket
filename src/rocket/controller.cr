module Rocket
  class Controller
    property actions, context

    def initialize
      @actions = {} of String => -> String
      @context = uninitialized HTTP::Server::Context

      {% for action in @type.methods %}
        @actions[{{action.name.stringify}}] = ->self.{{action.name}}
      {% end %}
    end

    def set_context(context : HTTP::Server::Context)
      @context = context
    end
  end
end
