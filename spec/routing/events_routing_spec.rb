require "spec_helper"

describe EventsController do
  resources_should_routes 'events'
  describe "routing /events other" do
    it "routes to #copy" do
      get("/events/12345/copy").should route_to("events#copy", id: '12345')
    end
  end
end
