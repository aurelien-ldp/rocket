# Rocket 🚀

A simple web framework with several purposes:
- Gather developers from different programming worlds
- Learn and, hopefully, permit others to learn

Rocket is inspired by [Rails](https://github.com/rails/rails). But doesn't aim to
be an exact copy of it. The goal is to gather as many programming experiences as
possible to develop a great mix of awesome features.

## Installation


Add this to your application's `shard.yml`:

```yaml
dependencies:
  rocket:
    github: aurelien-ldp/rocket
```


## Usage


```crystal
require "rocket"

# Define your controllers and actions as you wish
class HelloController < Rocket::Controller
  def get
    "GET !"
  end

  def post
    "POST !"
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
end

# Instantiate the router
router = Rocket::Router.new

# Add routes to the router
router.add_route("GET", "/", HelloController, "get")
router.add_route("POST", "/user", HelloController, "post")
router.add_route("PUT", "/", HelloController, "put")
router.add_route("PATCH", "/", HelloController, "patch")
router.add_route("DELETE", "/", HelloController, "delete")

# Launch the server with the router middleware
HTTP::Server.new("127.0.0.1", 8080, [
  HTTP::ErrorHandler.new,
  HTTP::LogHandler.new,
  HTTP::DeflateHandler.new,
  router
]).listen
```




## Development

Please refer to the Github's Project panel.

## Contributing

1. Fork it ( https://github.com/aurelien-ldp/rocket/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [aurelien-ldp](https://github.com/aurelien-ldp) Aurelien Louis Dit Picard - creator, maintainer
