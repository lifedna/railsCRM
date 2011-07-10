class User
  include Mongoid::Document
  include Mongoid::Timestamps

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  field :first_name, :type => String
  field :last_name,  :type => String
  field :email,      :type => String
  field :activated,  :type => Boolean

  validates :first_name, :email, :presence => true
  validates_uniqueness_of :email, :case_sensitive => false
  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation, :remember_me

  embeds_one :organisation

  accepts_nested_attributes_for :organisations
  
end
