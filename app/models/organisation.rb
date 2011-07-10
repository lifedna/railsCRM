class Organisation
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name

  embedded_in :user, :inverse_of => :organisation
end
