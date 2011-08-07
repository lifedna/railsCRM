class Contact
  include Mongoid::Document

  field :first_name
  field :last_name
  field :designation
  field :email
  field :phone

  embedded_in :lead, :inverse_of => :contacts

end
