require 'spec_helper'

describe Customer do

  before(:all) do
    load_current_user
    @customer = Factory(:customer)
  end

  let(:customer) {@customer.reload}

  it "should check proper creation of customer theough factory" do
    customer.should be_valid
  end

  it "should test full_name" do
    customer.full_name.should == "Sachin Singh"
  end

end