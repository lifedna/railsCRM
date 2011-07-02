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
  u.username 'demo_user'
  u.first_name "Test"
  u.last_name 'User'
  u.email 'user@test.com'
  u.password 'please'
  u.password_confirmation 'please'
end
