class User
  include Mongoid::Document
  include Mongoid::Timestamps

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable


  field :first_name, :type => String
  field :last_name,  :type => String
  field :activated,  :type => Boolean
  field :role
  field :invited,    :type => Boolean

  #attr_accessible :first_name, :last_name, :email, :password, :password_confirmation, :remember_me

  #referenced_in :organisation
  #references_many :prospects
  #references_many :leads
  embeds_many :roles

  before_create :set_role

  def role_name
    role
  end

  def name
    [first_name,last_name].join(" ")
  end

  private

  def set_role
    self.role = (invited? ? "user" : "admin")
  end

end
