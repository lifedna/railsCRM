class User
  include Mongoid::Document
  include Mongoid::Slug
  include Mongoid::Timestamps

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  field :username
  field :first_name
  field :last_name

  validates :username, :first_name, :presence => true
  validates_uniqueness_of :username, :email, :case_sensitive => false
  attr_accessible :username, :first_name, :last_name, :email, :password, :password_confirmation, :remember_me

  accepts_nested_attributes_for :organisations

end
