require "../src/rocket"
require "json"
require "yaml"

# Define your controllers and actions as you wish
class HelloController < Rocket::Controller
  def get
    user = { username: "aurel", password: "123456" }
    user.to_json
  end

  def index_json
    posts = [
      { title: "Hello 0", content: "This is the content 0" },
      { title: "Hello 1", content: "This is the content 1" },
      { title: "Hello 2", content: "This is the content 2" },
      { title: "Hello 3", content: "This is the content 3" },
    ]
    posts.to_json
  end

  def index_yaml
    posts = [
      { title: "Hello 0", content: "This is the content 0" },
      { title: "Hello 1", content: "This is the content 1" },
      { title: "Hello 2", content: "This is the content 2" },
      { title: "Hello 3", content: "This is the content 3" },
    ]
    posts.to_yaml
  end

  def post
    body = context.request.body
    params = body ? HTTP::Params.parse(body.gets_to_end) : ""
    "POST -> #{params.inspect}"
  end

  def put
    "PUT !"
  end

  def patch
    "PATCH !"
  end

  def delete
    "DELETE !"
  end

  def param
    "#{params}"
  end
end

# Add routes to the router
Rocket::ROUTER.add_route("GET", "/", HelloController, "get")
Rocket::ROUTER.add_route("GET", "/posts.json", HelloController, "index_json")
Rocket::ROUTER.add_route("GET", "/posts.yaml", HelloController, "index_yaml")
Rocket::ROUTER.add_route("POST", "/posts", HelloController, "post")
Rocket::ROUTER.add_route("PUT", "/", HelloController, "put")
Rocket::ROUTER.add_route("PATCH", "/", HelloController, "patch")
Rocket::ROUTER.add_route("DELETE", "/", HelloController, "delete")
# With parameters
Rocket::ROUTER.add_route("GET", "/hello/:name/:id/:nb", HelloController, "param")

# Start the server (default port is 3000)
# You can also add the port with Rocket::Server.start(3000)
Rocket::Server.start
