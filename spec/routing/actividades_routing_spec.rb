require "spec_helper"

describe ActividadesController do
  describe "routing" do

    it "routes to #index" do
      get("/actividades").should route_to("actividades#index")
    end

    it "routes to #new" do
      get("/actividades/new").should route_to("actividades#new")
    end

    it "routes to #show" do
      get("/actividades/1").should route_to("actividades#show", :id => "1")
    end

    it "routes to #edit" do
      get("/actividades/1/edit").should route_to("actividades#edit", :id => "1")
    end

    it "routes to #create" do
      post("/actividades").should route_to("actividades#create")
    end

    it "routes to #update" do
      put("/actividades/1").should route_to("actividades#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/actividades/1").should route_to("actividades#destroy", :id => "1")
    end

  end
end
