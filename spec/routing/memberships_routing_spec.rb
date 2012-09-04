require "spec_helper"

describe MembershipsController do
  nasted_resources_should_routes 'groups', 'memberships', [:index, :create, :update]
  describe "routing /my/memberships/:id" do
    it "routes to #destroy" do
      delete("/my/attendences/12345").should route_to("attendences#destroy", id: '12345')
    end
  end
end
