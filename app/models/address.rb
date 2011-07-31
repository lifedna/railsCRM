class Address
  include Mongoid::Document

  embedded_in :lead, :inverse_of => :addresses

end
