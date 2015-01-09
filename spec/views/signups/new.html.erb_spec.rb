require 'rails_helper'

RSpec.describe "signups/new", :type => :view do
  before(:each) do
    assign(:signup, Signup.new(
      :username => "MyString"
    ))
  end

  it "renders new user form" do
    render

    assert_select "form[action=?][method=?]", signups_path, "post" do

      assert_select "input#signup_username[name=?]", "signup[username]"
    end
  end
end
