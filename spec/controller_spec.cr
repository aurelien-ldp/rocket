require "./spec_helper"

describe Rocket::Controller do
  describe "#action_exists?" do
    it "returns true if action exists" do
      PostsController.new.action_exists? "index"
    end

    it "returns false if no action is found" do
      PostsController.new.action_exists? "action"
    end
  end
end
