require 'spec_helper'

describe Prospect do
  
  it {should validate_presence_of :first_name}
  it {should validate_presence_of :last_name}
  it {should validate_presence_of :date_of_birth}
  it {should be_referenced_in :organisation}
  it {should be_referenced_in :user}

  before(:all) do
    setup_user
  end

  let(:prospect) {Fabricate(:prospect, :organisation => @company, :user => @user)}

  it "should check proper creation of prospect theough factory" do
    prospect.should be_valid
  end

  it "should test full_name" do
    prospect.full_name.should == "#{prospect.first_name} #{prospect.last_name}"
  end
end
