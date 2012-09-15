require "spec_helper"

describe AttendencesController do
  nasted_resources_should_routes 'events', 'attendences', [:index, :create, :update]
  describe "routing /my/attendences/:id" do
    it "routes to #destroy" do
      delete("/my/attendences/12345").should route_to("attendences#destroy", id: '12345')
    end
  end
end
