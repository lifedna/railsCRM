require 'spec_helper'

describe Organisation do

  it {should reference_many :users}
  it {should validate_presence_of :name}
  
  
  describe "#activated!" do
    let(:company) {Fabricate(:organisation)}
  
    it "should be activated" do
      company.activated!.should be_true
    end
  end

end
