require 'ffaker'

Fabricator(:lead) do
  company_name {Faker::Company.name}
  source       "Meetings"
end
