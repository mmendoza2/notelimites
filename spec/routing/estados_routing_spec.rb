require "spec_helper"

describe EstadosController do
  describe "routing" do

    it "routes to #index" do
      get("/estados").should route_to("estados#index")
    end

    it "routes to #new" do
      get("/estados/new").should route_to("estados#new")
    end

    it "routes to #show" do
      get("/estados/1").should route_to("estados#show", :id => "1")
    end

    it "routes to #edit" do
      get("/estados/1/edit").should route_to("estados#edit", :id => "1")
    end

    it "routes to #create" do
      post("/estados").should route_to("estados#create")
    end

    it "routes to #update" do
      put("/estados/1").should route_to("estados#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/estados/1").should route_to("estados#destroy", :id => "1")
    end

  end
end
