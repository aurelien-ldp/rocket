require "./spec_helper"

describe Rocket::Router do
  router = Rocket::Router.new

  describe "#add_route" do
    router.add_route("POST", "/posts", PostsController, "index")

    it "creates a new route" do
      router.routes.size.should eq 1
    end

    it "instantiates the controller" do
      router.controllers.size.should eq 1
      router.controllers["PostsController"].itself.should_not be_nil
    end

    it "raises ActionNotFound" do
      expect_raises(Rocket::Exceptions::ActionNotFound) do
        router.add_route("GET", "/", PostsController, "")
      end
    end
  end

  describe "#call" do
    it "raises RouteNotFound" do
      expect_raises(Rocket::Exceptions::RouteNotFound) do
        router.call(generate_context)
      end
    end

    it "routes correctly" do
      context = generate_context
      router.add_route("GET", "/", PostsController, "index")
      router.call(context)
    end
  end
end
