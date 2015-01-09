class Account < ActiveRecord::Base
  has_many :users

  def self.for_user(user)
    user.account || NullAccount.new
  end
end
