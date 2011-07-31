class Lead
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name
  field :source

  validates :name, :source, :presence => true
  referenced_in :organisation
  embeds_many :contacts
  embeds_many :addresses
end
