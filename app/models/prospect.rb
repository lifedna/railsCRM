class Prospect
  include Mongoid::Document

  field :prefix
  field :first_name
  field :middle_name
  field :last_name
  field :dob, :type => Date
  field :gender

  PREFIXES = ['Mr.','Mrs.','Ms.']
  GENDER = ['Male', 'Female']

  validates :first_name, :last_name, :dob, :gender, :presence => true
  references_one :organisation
  references_one :user

  def full_name
    first_name +  " "  + last_name
  end

end
