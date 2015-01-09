class Signup
  attr_accessor :options

  def initialize(options)
    @options = options

    @account = Account.find_or_initialize_by(account_params)
    @user = @account.users.build(user_params)
  end

  def save
    @account.campaign_source = @options.slice("s", "ca","t").values.join("-")
    @account.remote_ip = @options[:remote_ip]
    @account.promo_code = @options[:promo_code]

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
