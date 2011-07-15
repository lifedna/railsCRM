class Organisation
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name
  field :active

  has_many :users
  accepts_nested_attributes_for :users

  def activated!
    self.active == 1 ? true : false
  end
end
