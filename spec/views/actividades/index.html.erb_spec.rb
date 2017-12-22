require 'spec_helper'

describe "actividades/index" do
  before(:each) do
    assign(:actividades, [
      stub_model(Actividad),
      stub_model(Actividad)
    ])
  end

  it "renders a list of actividades" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
