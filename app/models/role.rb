class Role
  include Mongoid::Document

  embedded_in :user, :inverse_of => :role

  ROLES = ["admin", "user"]

end