require "spec_helper"

describe PagesController do
  describe "routing /" do
    it "routes to #index" do
      get("/").should route_to("pages#index")
    end
  end
  describe "routing /about" do
    it "routes to #about" do
      get("/about").should route_to("pages#about")
    end
  end
  describe "routing /terms" do
    it "routes to #terms" do
      get("/terms").should route_to("pages#terms")
    end
  end
  describe "routing /policy" do
    it "routes to #policy" do
      get("/policy").should route_to("pages#policy")
    end
  end
  describe "routing /login" do
    it "routes to #login" do
      get("/login").should route_to("pages#login")
    end
  end
end
