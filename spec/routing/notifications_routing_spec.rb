require "spec_helper"

describe NotificationsController do
  describe "routing /my/notifications" do
    it "routes to #index" do
      get("/my/notifications").should route_to("notifications#index")
    end
    it "routes to #show" do
      get("/my/notifications/12345").should route_to("notifications#show", id: '12345')
    end
  end
end
