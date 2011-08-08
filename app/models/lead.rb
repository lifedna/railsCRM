class Lead
  include Mongoid::Document
  include Mongoid::Timestamps

  field :company_name
  field :source
  field :industry
  field :status
  field :website
  field :description
  embeds_many :contacts
  embeds_many :addresses

  validates :company_name, :source, :presence => true
  referenced_in :organisation

  accepts_nested_attributes_for :contacts
  accepts_nested_attributes_for :addresses

end
