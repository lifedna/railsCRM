require "ffaker"

Fabricator(:organisation) do
  name {"#{Faker::Company.name} #{Faker::Company.suffix}"}
  active 1
  #after_create {|org| Fabricate(:user, :organisation => org)}
end
