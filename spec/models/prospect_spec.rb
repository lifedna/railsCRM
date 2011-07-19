require 'spec_helper'

describe Prospect do
  
  it {should validate_presence_of :first_name}
  it {should validate_presence_of :last_name}
  it {should validate_presence_of :dob}
  it {should reference_one :organisations}
  it {should reference_one :user}

  before(:all) do
    login_user
    @prospect = Fabricate(:prospect, :organisation => @company, :user => @user)
  end

  let(:prospect) {@prospect.reload}

  it "should check proper creation of prospect theough factory" do
    prospect.should be_valid
  end

  it "should test full_name" do
    prospect.full_name.should == "Sachin Singh"
  end
end
