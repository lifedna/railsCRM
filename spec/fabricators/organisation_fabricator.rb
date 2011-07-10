require "ffaker"

Fabricator(:organisation) do
  name {"#{Faker::Company.name} #{Faker::Company.suffix}"}
end
