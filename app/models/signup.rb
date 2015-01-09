class Signup
  include ActiveModel::Model

  attr_accessor :username, :promo_code, :account_name, :remote_ip

  def initialize(options = {})
    @account = Account.find_or_initialize_by(name: options[:account_name])
    @account.remote_ip = options[:remote_ip]
    @account.promo_code = options[:promo_code]
    @account.campaign_source = options.slice("s", "ca","t").values.join("-")

    @user = @account.users.build(name: options[:username])
  end

  def save
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
    @options.require(:user).permit(:name)
  end

  def account_params
    @options.require(:account).permit([:name, :promo_code])
  end
end
