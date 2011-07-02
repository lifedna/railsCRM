require 'acceptance/acceptance_helper'

feature 'User Sign Up', %q{
  In order to use the application
  As a user
  I want to register myself.
} do

  scenario 'User Signs Up with valid data' do
    visit '/'
    click_link "Sign up"
    fill_in("Name", :with => "Demo Org.")
    fill_in("Username", :with => "username")
    fill_in("First name", :with => "Demo")
    fill_in("Last name", :with => "User")
    fill_in("Email", :with => "email@email.com")
    fill_in("Password", :with => 123456)
    fill_in("Password confirmation", :with => 123456)
    click_button "Sign up"
    page.should have_content("Welcome! You have signed up successfully.")
  end

  scenario 'User Signs Up with invalid data' do
    visit '/'
    click_link "Sign up"
    fill_in("Name", :with => "")
    fill_in("Username", :with => "username")
    fill_in("First name", :with => "")
    fill_in("Last name", :with => "Last")
    fill_in("Email", :with => "email@email.com")
    fill_in("Password", :with => 123456)
    fill_in("Password confirmation", :with => 123456)
    click_button "Sign up"
    save_and_open_page
    #    page.should have_content("")
  end
end
