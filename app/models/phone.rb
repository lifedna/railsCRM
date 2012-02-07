class Phone
  include Mongoid::Document

  PHONE_TYPE = ["Personal", "Office/Work", "Fax"]

  field :phone_type, :type => Integer, :default => PHONE_TYPE.index("Personal")
  field :country_code
  field :phone_number

  embedded_in :person, :inverse_of => :phones

end