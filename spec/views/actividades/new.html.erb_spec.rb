require 'spec_helper'

describe "actividades/new" do
  before(:each) do
    assign(:actividad, stub_model(Actividad).as_new_record)
  end

  it "renders new actividad form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", actividades_path, "post" do
    end
  end
end
