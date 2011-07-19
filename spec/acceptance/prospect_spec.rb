require 'acceptance/acceptance_helper'

feature "Prospects", %q{
  In order to manage a customers/prospects
  As an user
  I want to be able to create and manage prospects
} do

  background do
    create_user_and_login
    @prospect = Fabricate(:prospect, :organisation => @company, :user => @user)
    Prospect.create!(:first_name => "Sachin", :last_name => "Singh", :dob => Date.today - 24.years, :gender => 'Male')
    Prospect.create!(:first_name => 'Manoj', :last_name => 'Kumar', :dob => Date.today - 25.years, :gender => 'Male')
  end

  scenario 'Create a new prospect successfully' do
    find_link("Prospects").visible?
    click_link("Prospects")
    visit prospects_path
    current_path.should  == prospects_path
    click_link('Create Prospect')
    visit new_prospect_path
    current_path.should == new_prospect_path
    select('Mr.', :from => 'Prefix')
    fill_in 'First name', :with => @prospect.first_name
    fill_in 'Middle name', :with => @prospect.middle_name
    fill_in 'Last name', :with => @prospect.last_name
    fill_in 'Date of birth', :with => @prospect.dob
    select('Male', :from => 'Gender')
    click_button('Save')
    visit prospect_path
    page.should have_content("Prospect is created successfully.")
    current_path.should == prospect_path
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
  
  scenario "I should see Prospects index" do
    visit prospects_path
    page.should have_content('Sachin Singh')
    page.should have_content('Manoj Kumar')
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
