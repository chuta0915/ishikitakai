require "spec_helper"

describe AttendancesController do
  nasted_resources_should_routes 'events', 'attendances', [:index, :create, :update]
  describe "routing /my/attendances/:id" do
    it "routes to #destroy" do
      delete("/my/attendances/12345").should route_to("attendances#destroy", id: '12345')
    end
  end
end
