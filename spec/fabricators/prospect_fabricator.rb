require "ffaker"
Fabricator(:prospect) do
  prefix        {Faker::Name.prefix}
  first_name    {Faker::Name.first_name}
  middle_name   ""
  last_name     {Faker::Name.last_name}
  date_of_birth Date.today - 22.years
  gender        "Male"
end
