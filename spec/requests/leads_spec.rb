require 'spec_helper'

feature 'Leads' do

  background do
    create_user_and_login
    #@prospect
  end

  scenario 'Create a new lead' do
    find_link("Leads").visible?
    click_link("Leads")
    visit leads_path
    current_path.should == leads_path
    click_link("Add New Lead")
    visit new_lead_path
    fill_in 'Company', :with => "Demo company"
    fill_in 'Industry', :with => "Industry"
    fill_in 'First name', :with => "Fname"
    fill_in 'Last name', :with => "Lname"
    fill_in 'Designation', :with => "Title"
    fill_in 'Source', :with => "Source1"
    fill_in 'Status', :with => "Status1"
    fill_in 'Phone', :with => "phone_no"
    fill_in 'Email', :with => "email@email.com"
    fill_in 'Website', :with => "website.com"
    page.should have_content "Address"
    fill_in 'Street', :with => "Street1"
    fill_in 'City', :with => "City"
    select "India", :from => "Country"
    fill_in 'Pincode', :with => "111111"
    fill_in 'Description', :with => "IKnenoienrgiengoiengienirngieongnrgoien"
  end
end
