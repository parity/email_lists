class List < ActiveRecord::Base
	has_many :subscriptions, dependent: :destroy
	has_many :users, :through => :subscriptions
	before_save { name.downcase! }
	before_save { address.downcase! }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
	validates :name, presence: true, length: { maximum: 20},  uniqueness: { case_sensitive: false }
	validates :description, length: { maximum: 50}
	validates :address, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
end