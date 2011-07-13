class Prospect
  include Mongoid::Document

  field :prefix
  field :first_name
  field :middle_name
  field :last_name
  field :date_of_birth, :type => Date
  field :care_of
  field :gender

  PREFIXES = ['Mr.','Mrs.','Ms.']
  GENDER = ['Male', 'Female']

  validates :first_name, :last_name, :date_of_birth, :gender, :presence => true

  def full_name
    first_name +  " "  + last_name
  end

end