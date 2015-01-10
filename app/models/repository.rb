class Repository < ActiveRecord::Base
  validates :name, presence: true
  validates :url, presence: true
end
