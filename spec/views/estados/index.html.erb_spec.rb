require 'spec_helper'

describe "estados/index" do
  before(:each) do
    assign(:estados, [
      stub_model(Estado),
      stub_model(Estado)
    ])
  end

  it "renders a list of estados" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
