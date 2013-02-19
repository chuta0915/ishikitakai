require "spec_helper"

describe MembershipsController do
  nested_resources_should_routes 'groups', 'memberships', [:index, :create, :update]
  describe "routing /my/memberships/:id" do
    it "routes to #destroy" do
      delete("/my/attendances/12345").should route_to("attendances#destroy", id: '12345')
    end
  end
end
