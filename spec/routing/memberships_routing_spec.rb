require "spec_helper"

describe MembershipsController do
  describe "routing /my/memberships/:id" do
    it "routes to #update" do
      put("/my/memberships/12345").should route_to("memberships#update", id: '12345')
    end
    it "routes to #destroy" do
      delete("/my/memberships/12345").should route_to("memberships#destroy", id: '12345')
    end
  end
end
