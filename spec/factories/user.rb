#Factory.define :user do |u|
#  u.email  {Factory.next(:email) }
#  u.password '123456'
#  u.password_confirmation '123456'
#end
#
#
#Factory.sequence :email do |n|
#  "email#{n}@emailcom"
#end

Factory.define :user do |u|
  u.name 'Test User'
  u.email 'user@test.com'
  u.password 'please'
end