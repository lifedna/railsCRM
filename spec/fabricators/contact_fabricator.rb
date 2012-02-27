require "ffaker"

Fabricator(:contact) do
  first_name  "Fname"
  last_name   "Lname"
  designation "Desgination1"
  email       "email@email.com"
  #phone       "991100221"
end

# Fabricator(:lead_contact, from: :contact) do
#   first_name "Fname"
#   last_name  "Lname"
#   designation "Desgination1"
#   email       "email@email.com"
#   phone       "991100221"
#   contactable
# end
