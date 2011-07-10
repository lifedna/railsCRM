require 'acceptance/acceptance_helper'

feature 'User Signs In', %q{
  In order to use the application
  As a registered user
  I should be able to sign in.
} do

  background do
    @user = Fabricate(:user)
    @company = Fabricate(:organisation, :user => @user)
  end

  let(:user) {@user.reload}
  
  scenario 'User is registered and activated' do
    user.confirm!
    visit '/'
    click_link 'Login'
    fill_in("Email", :with => user.email)
    fill_in("Password", :with => user.password)
    click_button 'Sign in'
    page.should have_content("Signed in successfully.")
  end

  scenario 'User is not registered' do
    visit '/'
    click_link 'Login'
    fill_in("Email", :with => "unregistered@user.com")
    fill_in("Password", :with => "12345678")
    click_button "Sign in"
    page.should have_content("Sign up")
    page.should have_content("Login")
  end

  scenario 'User is registered but not activated' do
    reg_user  = Fabricate(:user)
    c = Fabricate(:organisation, :user => user)
    visit '/'
    click_link 'Login'
    fill_in("Email", :with => reg_user.email)
    fill_in("Password", :with => reg_user.password)
    click_button 'Sign in'
    page.should have_content("Sign up")
    page.should have_content("Login")
    page.should_not have_content("Logout")
  end

end
