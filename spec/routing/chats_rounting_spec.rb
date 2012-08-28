require "spec_helper"

describe ChatsController do
  nasted_resources_should_routes 'groups', 'chats', [:index, :show, :create, :destroy]
  describe "routing /groups/:group_id/chats other" do
    it "routes to #authentication" do
      post("/chats/authentication").should route_to("chats#authentication")
    end
  end
end
