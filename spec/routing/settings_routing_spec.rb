require "spec_helper"

describe SettingsController do
  describe "routing /my/setting" do
    it "routes to #show" do
      get("/my/setting").should route_to("settings#show")
    end
  end
end
