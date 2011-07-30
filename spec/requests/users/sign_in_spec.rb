require 'spec_helper'

feature 'User Signs In' do

  background do
    @company = Fabricate(:organisation)
    @user = Fabricate(:user, :organisation => @company)
  end

  let(:user) {@user.reload}
  let(:company) {@company.reload}

  scenario 'User is registered and activated' do
    user.confirm!
    user.organisation.activated!
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
    c = Fabricate(:organisation)
    reg_user = Fabricate(:user, :organisation => c)
    visit '/'
    click_link 'Login'
    fill_in("Email", :with => reg_user.email)
    fill_in("Password", :with => reg_user.password)
    click_button 'Sign in'
    page.should have_content("Sign up")
    page.should have_content("Login")
    page.should_not have_content("Logout")
  end

  scenario "Company not active" do
    org = Fabricate(:organisation, :active => 0)
    u = Fabricate(:user, :organisation => org)
    u.confirm!
    visit '/'
    click_link "Login"
    fill_in("Email", :with => u.email)
    fill_in("Password", :with => u.password)
    click_button "Sign in"
    #page.should have_content("Sorry either user/company not yet activated")
    #page.should have_content("Login")
  end

end
