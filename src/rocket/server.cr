require "http/server"

module Rocket
  # The Server listen on `Rocket::HOST` and `Rocket::PORT`.
  # Another port can optionally be passed to the start function.
  #
  class Server
    MIDDLEWARE = [
      HTTP::ErrorHandler.new,
      HTTP::LogHandler.new,
      ROUTER,
    ]

    def self.start(port = nil)
      puts "Starting server on http://#{HOST}:#{port || PORT}"
      HTTP::Server.new(HOST, port || PORT, MIDDLEWARE).listen
    end
  end
end
