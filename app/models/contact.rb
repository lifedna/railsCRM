class Contact
  include Mongoid::Document

  embedded_in :lead, :inverse_of => :contacts

end
