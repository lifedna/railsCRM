require 'acceptance/acceptance_helper'
  include EmailSpec::Helpers
  include EmailSpec::Matchers

feature 'User Sign Up', %q{
  In order to use the application
  As a user
  I want to register myself.
} do

  scenario 'User Signs Up with valid data' do
    visit '/'
    click_link "Sign up"
    fill_in("Name", :with => "Demo Org.")
    fill_in("First name", :with => "Demo")
    fill_in("Last name", :with => "User")
    fill_in("Email", :with => "email@email.com")
    fill_in("Password", :with => 123456)
    fill_in("Password confirmation", :with => 123456)
    click_button "Sign up"
    page.should have_content('You have signed up successfully. However, we could not sign you in because your account is unconfirmed.')
    unread_emails_for("email@email.com").size.should == 1
  end

  scenario 'User Signs Up with incomplete data' do
    visit '/'
    click_link "Sign up"
    fill_in("Name", :with => "")
    fill_in("First name", :with => "")
    fill_in("Last name", :with => "Last")
    fill_in("Email", :with => "email1@email.com")
    fill_in("Password", :with => 123456)
    fill_in("Password confirmation", :with => 123456)
    click_button "Sign up"
    page.should have_content("can't be blank")
    unread_emails_for("email1@email.com").size.should eql 0
  end
end
