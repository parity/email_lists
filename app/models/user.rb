class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #   	  :recoverable, :rememberable, :trackable, :validatable
  devise :database_authenticatable,
    	  :recoverable, :rememberable, :trackable, :validatable

	has_many :subscriptions, dependent: :destroy
	has_many :lists, :through => :subscriptions		
	validates :name, presence: true,  length: {maximum: 50 }

	belongs_to :role
	before_save :set_role
	before_validation :set_password , on: :create

	def set_role
		self.role_id=Role.find_or_create_by(name: "user").id
	end	

	def set_password
		self.password="#{self.name.split(" ").first}_1234567"
	end	
end

