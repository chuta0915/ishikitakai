require "spec_helper"

describe AttendencesController do
  describe "routing /my/attendences/:id" do
    it "routes to #update" do
      put("/my/attendences/12345").should route_to("attendences#update", id: '12345')
    end
    it "routes to #destroy" do
      delete("/my/attendences/12345").should route_to("attendences#destroy", id: '12345')
    end
  end
end
