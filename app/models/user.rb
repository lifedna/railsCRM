class User
  include Mongoid::Document
  include Mongoid::Timestamps

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :invite_for => 2.weeks

  field :first_name, :type => String
  field :last_name,  :type => String
  field :email,      :type => String
  field :activated,  :type => Boolean
  field :role
  field :invited,    :type => Boolean

  validates :first_name, :email, :presence => true
  #validates_uniqueness_of :email, :case_sensitive => false
  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation, :remember_me

  accepts_nested_attributes_for :organisation
  referenced_in :organisation
  references_many :prospects
  embeds_many :roles
  
  before_create :set_role


  def role_name
    role
  end

  def invited?
    invited
  end
  

  private

  def set_role
    self.role = invited? ? "user" : "admin"
  end
 

end
