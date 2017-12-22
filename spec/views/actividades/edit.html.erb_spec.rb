require 'spec_helper'

describe "actividades/edit" do
  before(:each) do
    @actividad = assign(:actividad, stub_model(Actividad))
  end

  it "renders the edit actividad form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", actividad_path(@actividad), "post" do
    end
  end
end
