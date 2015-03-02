class User < ActiveRecord::Base
	devise :database_authenticatable,
        :recoverable, :rememberable, :trackable, :validatable

	has_many :subscriptions, dependent: :destroy
	has_many :lists, :through => :subscriptions
	belongs_to :role
	before_save {self.email = email.downcase}
	validates :name, presence: true,  length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
	validates :email, presence: true,  format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

	before_validation :set_role , on: :create
	before_validation :set_password , on: :create

	def set_role
		self.role_id=Role.find_by(name: "user").id if self.role_id.nil?
	end	

	def set_password
		self.password="#{self.name.split(" ").first}_1234567" if self.password.nil?
	end	
end