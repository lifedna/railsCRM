class Organisation
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name
  field :active

  references_many :users, :dependent => :delete
  references_many :prospects, :dependent => :delete

  validates :name, :presence => true

  def activated!
    self.active == 1 ? true : false
  end
end
