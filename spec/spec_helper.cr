require "spec"
require "../src/rocket"

class PostsController < Rocket::Controller
  def index
    "OK"
  end
end

def generate_context
  request = HTTP::Request.new("GET", "/")
  io = MemoryIO.new
  response = HTTP::Server::Response.new(io)
  HTTP::Server::Context.new(request, response)
end
