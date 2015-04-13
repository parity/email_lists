class Subscription < ActiveRecord::Base
  belongs_to :list
  belongs_to :user
  before_create :check_unique

  def check_unique
    unique = Subscription.where("user_id = ? and list_id = ?", self.user_id, self.list_id)
  	raise "Could not create, it already exists..." if unique.present?
  end
end
