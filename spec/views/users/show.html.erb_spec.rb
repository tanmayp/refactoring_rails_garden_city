require 'rails_helper'

RSpec.describe "users/show", :type => :view do
  context "without an account" do
    before(:each) do
      @account = assign(:account, Account.create!(name: "Name"))
      @user = assign(:user, @account.users.create!(
      :name => "Name"
      ))
    end

    it "renders attributes in <p>" do
      render
      expect(rendered).to match(/Name/)
    end
  end

  context "without an account" do
    before(:each) do
      @user = assign(:user, User.create!(
      :name => "Name"
      ))
    end

    it "renders attributes in <p>" do
      render
      expect(rendered).to match(/Name/)
    end
  end
end
