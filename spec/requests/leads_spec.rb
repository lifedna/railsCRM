require 'spec_helper'

feature 'Leads' do

  background do
    create_user_and_login
    @lead = Fabricate(:lead)
    @contact = Fabricate(:contact, :lead => @lead)
    @address = Fabricate(:address, :lead => @lead)
  end

  scenario 'Create a new lead' do
    find_link("Leads").visible?
    click_link("Leads")
    visit leads_path
    current_path.should == leads_path
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
    click_button "Create Lead"
    page.should have_content "Lead was successfully created."
  end
end
