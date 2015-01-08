class Signup
  attr_accessor :params, :cookies, :remote_ip

  def initialize(params, cookies, remote_ip)
    @params = params
    @cookies = cookies
    @remote_ip = remote_ip
    @account = Account.find_or_initialize_by(account_params)
    @user = @account.users.build(user_params)
  end

  def save
    campaign_source = [@cookies["s"], @cookies["ca"], @cookies["t"]].join("-")
    @account.campaign_source = campaign_source
    @account.remote_ip = @remote_ip
    @account.promo_code = params[:promo_code]

    @user.save && @account.save
  end

  def user
    @user
  end

  def account
    @account
  end

private

  def user_params
    @params.require(:user).permit(:name)
  end

  def account_params
    @params.require(:account).permit([:name, :promo_code])
  end
end
