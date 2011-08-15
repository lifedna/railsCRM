class Contact
  include Mongoid::Document

  field :first_name
  field :last_name
  field :designation
  field :email
  field :linkedin
  field :twitter
  field :skype
  
  referenced_in :contactable, :polymorphic => true, :inverse_of => :contact
  embeds_many :phones
  embeds_one :address, :as => :addressable
  #embedded_in :prospect_contact

  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :phones

  validates :first_name, :email, :designation, :presence => true


  def full_name
    "#{first_name} #{try(:last_name)}".strip
  end

  
end
