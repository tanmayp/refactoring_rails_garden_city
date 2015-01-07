class User < ActiveRecord::Base
  belongs_to :account

  validates :name, presence: true
  validates :name, uniqueness: true
end
