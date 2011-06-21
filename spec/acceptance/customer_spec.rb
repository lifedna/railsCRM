require 'acceptance/acceptance_helper'

feature "Customers", %q{
  In order to manage a crm
  As an user
  I want to create and manage customers
} do

  background do
    Customer.create!(:first_name => "Sachin", :last_name => "Singh", :date_of_birth => Date.today - 24.years, :gender => 'Male')
    Customer.create!(:first_name => 'Manoj', :last_name => 'Kumar', :date_of_birth => Date.today - 25.years, :gender => 'Male')
  end

  scenario "Customers index" do
    visit customers_path
    page.should have_content('Sachin Singh')
    page.should have_content('Manoj Kumar')
  end

  scenario 'Create a new customer successfully' do
    visit new_customer_path
    select('Mr.', :from => 'Prefix')
    fill_in 'First name', :with => 'Ravindra'
    fill_in 'Middle name', :with => 'Kumar'
    fill_in 'Last name', :with => 'Kumawat'
    fill_in 'Date of birth', :with => Date.today - 22.years
    select('Male', :from => 'Gender')
    click_button('Save')
    page.should have_content("Customer is created successfully.")
  end

  scenario 'Create a new customer fails if mandetory fields are not supplied' do
    visit new_customer_path
    select('Mr.', :from => 'Prefix')
    fill_in 'First name', :with => ''
    fill_in 'Middle name', :with => ''
    fill_in 'Last name', :with => ''
    fill_in 'Date of birth', :with => ''
    select('', :from => 'Gender')
    click_button('Save')
    page.should have_content("Error while creating Customer.")
    page.should have_content('can\'t be blank')
  end

  scenario 'successfully update a customer' do
    visit customers_path
    click_link('Edit')
    fill_in 'First name', :with => 'Hitendra'
    fill_in 'Middle name', :with => 'Singh'
    fill_in 'Last name', :with => 'Chauhan'
    click_button('Save')
    page.should have_content("Successfully updated Hitendra Chauhan")
    page.should have_content('Hitendra Chauhan')
  end

  scenario 'error on updating a customer' do
    visit customers_path
    click_link('Edit')
    fill_in 'First name', :with => ''
    fill_in 'Middle name', :with => 'Singh'
    fill_in 'Last name', :with => 'Chauhan'
    click_button('Save')
    page.should have_content("Error while updating customer.")
  end

  scenario 'deleting a customer' do
    visit customers_path
    click_link('Destroy')
    page.should have_content("Successfully deleted customer.")
  end

end