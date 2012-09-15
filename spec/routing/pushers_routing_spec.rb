require "spec_helper"

describe ChatsController do
  describe "routing /pusher/authentication other" do
    it "routes to #authentication" do
      post("/pusher/authentication").should route_to("pushers#authentication")
    end
  end
end
