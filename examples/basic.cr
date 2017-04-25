require "../src/rocket"

# Define your controllers and actions as you wish
class HelloController < Rocket::Controller
  def get
    "GET !"
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
Rocket::ROUTER.add_route("POST", "/posts", HelloController, "post")
Rocket::ROUTER.add_route("PUT", "/", HelloController, "put")
Rocket::ROUTER.add_route("PATCH", "/", HelloController, "patch")
Rocket::ROUTER.add_route("DELETE", "/", HelloController, "delete")
# With parameters
Rocket::ROUTER.add_route("GET", "/hello/:name/:id/:nb", HelloController, "param")

# Start the server (default port is 3000)
# You can also add the port with Rocket::Server.start(3000)
Rocket::Server.start
