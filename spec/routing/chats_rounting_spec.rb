require "spec_helper"

describe ChatsController do
  describe "routing /groups/:group_id/chats" do
    it "routes to #index" do
      get("/groups/12345/chats").should route_to("chats#index", :group_id => '12345')
    end
    it "routes to #show" do
      get("/groups/12345/chats/23456").should route_to("chats#show", :group_id => '12345', :id => '23456')
    end
    it "routes to #create" do
      post("/groups/12345/chats").should route_to("chats#create", :group_id => '12345')
    end
    it "routes to #destroy" do
      delete("/groups/12345/chats/23456").should route_to("chats#destroy", :group_id => '12345', :id => '23456')
    end
    it "routes to #authentication" do
      post("/chats/authentication").should route_to("chats#authentication")
    end
  end
end
