class User < ActiveRecord::Base
	devise :database_authenticatable,
        :recoverable, :rememberable, :trackable, :validatable

	has_many :subscriptions, dependent: :destroy
	has_many :lists, :through => :subscriptions
	belongs_to :role
	validates :name, presence: true,  length: { maximum: 50 }
	before_validation :set_role , on: :create
	before_validation :set_password , on: :create

	def set_role
		self.role_id=Role.find_by(name: "user").id if self.role_id.nil?
	end

	def set_password
		self.password="#{self.name.split(" ").first}_1234567" if self.password.nil?
	end
end