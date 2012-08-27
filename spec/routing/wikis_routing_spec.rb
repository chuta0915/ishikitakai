describe WikisController do
  describe "routing /groups/:group_id/wikis" do
    it "routes to #index" do
      get("/groups/12345/wikis").should route_to("wikis#index", :group_id => '12345')
    end
    it "routes to #new" do
      get("/groups/12345/wikis/new").should route_to("wikis#new", :group_id => '12345')
    end
    it "routes to #show" do
      get("/groups/12345/wikis/23456").should route_to("wikis#show", :group_id => '12345', :id => '23456')
    end
    it "routes to #edit" do
      get("/groups/12345/wikis/23456/edit").should route_to("wikis#edit", :group_id => '12345', :id => '23456')
    end
    it "routes to #create" do
      post("/groups/12345/wikis").should route_to("wikis#create", :group_id => '12345')
    end
    it "routes to #destroy" do
      delete("/groups/12345/wikis/23456").should route_to("wikis#destroy", :group_id => '12345', :id => '23456')
    end
  end

  describe "routing /events/:event_id/wikis" do
    it "routes to #index" do
      get("/events/12345/wikis").should route_to("wikis#index", :event_id => '12345')
    end
    it "routes to #new" do
      get("/events/12345/wikis/new").should route_to("wikis#new", :event_id => '12345')
    end
    it "routes to #show" do
      get("/events/12345/wikis/23456").should route_to("wikis#show", :event_id => '12345', :id => '23456')
    end
    it "routes to #edit" do
      get("/events/12345/wikis/23456/edit").should route_to("wikis#edit", :event_id => '12345', :id => '23456')
    end
    it "routes to #create" do
      post("/events/12345/wikis").should route_to("wikis#create", :event_id => '12345')
    end
    it "routes to #destroy" do
      delete("/events/12345/wikis/23456").should route_to("wikis#destroy", :event_id => '12345', :id => '23456')
    end
  end
end
