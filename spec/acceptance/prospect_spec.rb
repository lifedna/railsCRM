require 'acceptance/acceptance_helper'

feature "Prospects", %q{
  In order to manage a crm
  As an user
  I want to create and manage prospects
} do

  background do
    @user = Fabricate(:user)
    Fabricate(:organisation, :user => @user)
    visit '/'
    click_link 'Login'
    fill_in("Email", :with => @user.email)
    fill_in("Password", :with => @user.password)
    click_button 'Sign in'
    Prospect.create!(:first_name => "Sachin", :last_name => "Singh", :date_of_birth => Date.today - 24.years, :gender => 'Male')
    Prospect.create!(:first_name => 'Manoj', :last_name => 'Kumar', :date_of_birth => Date.today - 25.years, :gender => 'Male')
  end

  scenario "Prospects index" do
    visit prospects_path
    page.should have_content('Sachin Singh')
    page.should have_content('Manoj Kumar')
  end

  scenario 'Create a new prospect successfully' do
    visit new_prospect_path
    select('Mr.', :from => 'Prefix')
    fill_in 'First name', :with => 'Ravindra'
    fill_in 'Middle name', :with => 'Kumar'
    fill_in 'Last name', :with => 'Kumawat'
    fill_in 'Date of birth', :with => Date.today - 22.years
    select('Male', :from => 'Gender')
    click_button('Save')
    page.should have_content("Prospect is created successfully.")
  end

  scenario 'Create a new prospect fails if mandetory fields are not supplied' do
    visit new_prospect_path
    select('Mr.', :from => 'Prefix')
    fill_in 'First name', :with => ''
    fill_in 'Middle name', :with => ''
    fill_in 'Last name', :with => ''
    fill_in 'Date of birth', :with => ''
    select('', :from => 'Gender')
    click_button('Save')
    page.should have_content("Error while creating Prospect.")
    page.should have_content('can\'t be blank')
  end

  scenario 'successfully update a prospect' do
    visit prospects_path
    click_link('Edit')
    fill_in 'First name', :with => 'Hitendra'
    fill_in 'Middle name', :with => 'Singh'
    fill_in 'Last name', :with => 'Chauhan'
    click_button('Save')
    page.should have_content("Successfully updated Hitendra Chauhan")
    page.should have_content('Hitendra Chauhan')
  end

  scenario 'error on updating a prospect' do
    visit prospects_path
    click_link('Edit')
    fill_in 'First name', :with => ''
    fill_in 'Middle name', :with => 'Singh'
    fill_in 'Last name', :with => 'Chauhan'
    click_button('Save')
    page.should have_content("Error while updating prospect.")
  end

  scenario 'deleting a prospect' do
    visit prospects_path
    click_link('Destroy')
    page.should have_content("Successfully deleted prospect.")
  end

end