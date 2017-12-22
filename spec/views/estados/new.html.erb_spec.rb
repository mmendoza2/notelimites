require 'spec_helper'

describe "estados/new" do
  before(:each) do
    assign(:estado, stub_model(Estado).as_new_record)
  end

  it "renders new estado form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", estados_path, "post" do
    end
  end
end
