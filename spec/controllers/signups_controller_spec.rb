require 'rails_helper'

RSpec.describe SignupsController, :type => :controller do
  let(:valid_attributes) {
    {
      signup: {
        username: "marshally",
        account_name: "code climate",
        promo_code: "abc123"
      }
    }
  }

  let(:invalid_attributes) {
    { name: nil }
  }

  let(:valid_session) { {} }

  describe "GET new" do
    it "assigns a new user as @user" do
      get :new, {}, valid_session
      expect(assigns(:signup)).to be_a(Signup)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new User" do
        expect {
          post :create, valid_attributes, valid_session
        }.to change(User, :count).by(1)
      end

      it "creates a new Account" do
        expect {
          post :create, valid_attributes, valid_session
        }.to change(Account, :count).by(1)
      end

      it "assigns a newly created user as @user" do
        post :create, valid_attributes, valid_session
        expect(assigns(:signup).user).to be_a(User)
        expect(assigns(:signup).user).to be_persisted
      end

      it "assigns a newly created account as @account" do
        post :create, valid_attributes, valid_session
        expect(assigns(:signup).account).to be_a(Account)
        expect(assigns(:signup).account).to be_persisted
      end

      it "decodes google campaign source" do
        request.cookies["s"] = "s"
        request.cookies["ca"] = "ca"
        request.cookies["t"] = "t"

        post :create, valid_attributes, valid_session
        expect(assigns(:signup).account.campaign_source).to eq("s-ca-t")
      end

      it "stores a promo code" do
        post :create, valid_attributes, valid_session
        expect(assigns(:signup).account.promo_code).to eq("abc123")
      end

      it "stores the remote_ip" do
        expect(request).to receive(:remote_ip).and_return "1.1.1.1"
        post :create, valid_attributes, valid_session
        expect(assigns(:signup).account.remote_ip).to eq("1.1.1.1")
      end

      it "redirects to the created user" do
        post :create, valid_attributes, valid_session
        expect(response).to redirect_to(User.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved user as @user" do
        post :create, {signup: invalid_attributes, account: invalid_attributes}, valid_session
        expect(assigns(:signup).user).to be_a_new(User)
      end

      it "re-renders the 'new' template" do
        post :create, {signup: invalid_attributes, account: invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end
end
