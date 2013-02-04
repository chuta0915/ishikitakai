require "spec_helper"

describe UsersController do
  resources_should_routes 'users', [:show]
  resource_should_routes 'users', [:edit, :update]

  describe "routing /my/users" do
    it "routes to #destroy" do
      delete("/my").should route_to("users#destroy")
    end
    it "routes to #show" do
      get("/my").should route_to("users#show")
    end
  end
end
