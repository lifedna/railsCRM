require 'spec_helper'

describe Prospect do

  before(:all) do
    load_current_user
    @prospect = Factory(:prospect)
  end

  let(:prospect) {@prospect.reload}

  it "should check proper creation of prospect theough factory" do
    prospect.should be_valid
  end

  it "should test full_name" do
    prospect.full_name.should == "Sachin Singh"
  end

end