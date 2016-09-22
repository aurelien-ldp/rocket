require "http/server"

module Rocket
  class Server
    def self.start(port)
      puts "Starting server on http://#{HOST}:#{port || PORT}"
      HTTP::Server.new(HOST, port || PORT, [
        HTTP::ErrorHandler.new,
        HTTP::LogHandler.new,
        HTTP::DeflateHandler.new,
        ROUTER
      ]).listen
    end
  end
end
