require 'acceptance/acceptance_helper'

feature 'User Signs In', %q{
  In order to use the application
  As a registered user
  I should be able to sign in.
} do

  background do 
     @user = Fabricate(:user)
  end

  let(:user) {@user.reload}
  
  scenario 'User is registered' do
    visit '/'
    click_link 'Login'
    fill_in("Email", :with => user.email)
    fill_in("Password", :with => user.password)
    save_and_open_page
  end

end
