require 'spec_helper'

describe Organisation do

  describe "#activated!" do
    let(:company) {Fabricate(:organisation)}
  
    it "should be activated" do
      p company
      company.activated!.should be_true  
    end
  end

end
