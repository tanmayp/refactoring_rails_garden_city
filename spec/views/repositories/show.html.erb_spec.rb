require 'rails_helper'

RSpec.describe "repositories/show", :type => :view do
  before(:each) do
    @repository = assign(:repository, Repository.create!(
      :name => "Name",
      :url => "Url",
      :enabled => false,
      :user_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Url/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/1/)
  end
end
