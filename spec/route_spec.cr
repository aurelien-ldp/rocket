require "./spec_helper"

describe Rocket::Route do
  route = Rocket::Route.new("GET", "/posts/:id/:name/:ok/", PostsController.new, "index")

  describe "#new" do
    it "creates the correct regex" do
      (route.regex === "/posts/12/rocket/OK").should be_true
      (route.regex === "/posts/12/rocket/").should be_false
      (route.regex === "/pts/12/rocket/OK").should be_false
    end

    it "parses the correct param names" do
      route.param_names.should eq ["id", "name", "ok"]
    end
  end

  describe "#call_action" do
    it "generates the correct params hash" do
      context = generate_context
      context.request.path = "//posts//id//name/ok/"
      context.request.query = "param1=ok&param2"
      route.call_action(context)
      route.controller.params.should eq Hash{"id" => "id", "name" => "name", "ok" => "ok", "param1" => "ok", "param2" => nil}
    end
  end
end
