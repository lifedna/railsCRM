require 'spec_helper'

feature 'Leads' do

  background do
    create_user_and_login
    @lead = Fabricate(:lead)
    @contact = Fabricate(:contact, :lead => @lead)
    @address = Fabricate(:address, :lead => @lead)
    find_link("Leads").visible?
    click_link("Leads")
    visit leads_path
    current_path.should == leads_path
  end


  scenario "List all leads" do
    within("h1") do
      page.should have_content "Listing Leads"
    end
  end

  scenario 'Create a new lead' do
    click_link("Add New Lead")
    current_path.should == new_lead_path
    fill_in 'Company', :with => @lead.company_name
    fill_in 'Industry', :with => @lead.industry
    fill_in 'First name', :with => @contact.first_name
    fill_in 'Last name', :with => @contact.last_name
    fill_in 'Designation', :with => @contact.designation
    fill_in 'Source', :with => @lead.source
    fill_in 'Status', :with => @lead.status
    fill_in 'Email', :with => @contact.email
    fill_in 'Phone', :with => @contact.phone
    fill_in 'Website', :with => "website.com"
    page.should have_content "Address"
    fill_in 'Street', :with => @address.street
    fill_in 'City', :with => @address.city
    select "India", :from => "Country"
    fill_in 'Pincode', :with => @address.pincode
    fill_in 'Description', :with => "IKnenoienrgiengoiengienirngieongnrgoien"
    click_button "Save Lead"
    page.should have_content "Lead was successfully created."
  end

  scenario 'Edit a lead' do
    click_link("Edit")
    current_path.should == edit_lead_path(@lead)
    fill_in 'Company', :with => "Edited Company"
    fill_in 'Industry', :with => "New Industry"
    fill_in 'Website', :with => "website.com"
    click_button "Save Lead"
    page.should have_content "Lead was successfully updated."
  end
end
