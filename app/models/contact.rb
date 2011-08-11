class Contact
  include Mongoid::Document

  field :first_name
  field :last_name
  field :designation
  field :email
  field :phone

  embedded_in :lead, :inverse_of => :contacts

  validates :first_name, :email, :phone, :presence => true


  def full_name
    "#{first_name}" "#{try(:last_name)}"
  end

  
end
