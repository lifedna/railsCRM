class Address
  include Mongoid::Document

  field :street
  field :city
  field :pincode
  field :country

  embedded_in :lead, :inverse_of => :addresses

end
