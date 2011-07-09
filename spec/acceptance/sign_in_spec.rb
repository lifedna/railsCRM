require 'acceptance/acceptance_helper'

feature 'User Signs In', %q{
  In order to use the application
  As a registered user
  I should be able to sign in.
} do


  scenario 'User is registered' do
    visit '/'
    click_link 'Login'
    fill_in("Email", :with => "abc@def.com")
    fill_in("Password", :with => "12345678")
    save_and_open_page
  end

end
