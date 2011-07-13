require "ffaker"
Fabricator(:prospect) do
  prefix "Mr."
  first_name "Sachin"
  middle_name ""
  last_name "Singh"
  date_of_birth "09-06-1987"
  care_of ""
  gender "Male"
end