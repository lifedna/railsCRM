require 'ffaker'

Fabricator(:lead) do
  company_name {Faker::Company.name}
  source       "Meetings"
  industry     "Industry"
  status       "Status"
  #after_create { | lead | lead.contacts << Fabricate.build(:contact) }
  #after_create { | lead | lead.addresses << Fabricate.build(:address) }
end
