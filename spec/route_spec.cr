require "./spec_helper"

describe Rocket::Route do
  route = Rocket::Route.new("POST", "/posts", PostsController.new, "index")
  context = HTTP::Server::Context.new(HTTP::Request.new("GET", "/"), HTTP::Server::Response.new(MemoryIO.new))
end
