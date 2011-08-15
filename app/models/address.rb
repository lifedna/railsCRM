class Address
  include Mongoid::Document

  field :street1
  field :street2
  field :city
  field :zipcode
  field :country

  embedded_in :addressable, :polymorphic => true

  validates :street1, :city, :zipcode, :country, :presence => true


  def full_address
  	"#{street1}, #{try(:street2)}, #{city}, #{zipcode}, #{country}"
  end


end
