require 'spec_helper'

describe "actividades/show" do
  before(:each) do
    @actividad = assign(:actividad, stub_model(Actividad))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
