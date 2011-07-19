require 'spec_helper'

describe User do

  before :all do
    @company = Fabricate(:organisation)
  end
  
  let(:user) { Fabricate(:user, :organisation => @company) }

  it { should validate_presence_of :first_name }
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }
  it { should be_referenced_in :organisation }
  it { should reference_many :prospects }
  it { should embed_many :roles }
    

  context "should create a new instance given valid attributes" do
    new_user = Fabricate.build(:user, :organisation => @company)
    specify { new_user.should be_valid}
  end

  context "should not create new instance given invalid attributes" do
    new_user = Fabricate.build(:user, :first_name => "", :organisation => @company)
    specify { new_user.should_not be_valid }
  end 

  describe ".role" do
    context "User is the first user of company" do
      before :all do
        @c = Fabricate(:organisation)
        @u = Fabricate(:user, :organisation => @c)
      end
      specify { @u.role_name.should eql "admin"}
    end

    context "User is not the first user of company" do
      before :all do
        @c = Fabricate(:organisation)
        @u = Fabricate(:user, :organisation => @c)
        @new_u = Fabricate(:user, :invited => 1, :organisation => @c)
      end

      let(:new_u) {@new_u}
      specify { @c.users.size.should eql 2}
      specify { new_u.invited?.should be_true}
      specify { new_u.role_name.should_not eql "admin"}
      specify { new_u.role_name.should eql 'user'}
    end

  end
end
=begin  
  it "should require an email address" do
    no_email_user = Factory.build(:user, :email => "")
    no_email_user.should_not be_valid
  end
  
  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email => address))
      valid_email_user.should be_valid
    end
  end
  
  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      invalid_email_user = User.new(@attr.merge(:email => address))
      invalid_email_user.should_not be_valid
    end
  end
  
  it "should reject duplicate email addresses" do
    User.create!(@attr)
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end
  
  it "should reject email addresses identical up to case" do
    upcased_email = @attr[:email].upcase
    User.create!(@attr.merge(:email => upcased_email))
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end
  
  describe "passwords" do

    let(:user) {@user.reload}

    it "should have a password attribute" do
      user.should respond_to(:password)
    end

    it "should have a password confirmation attribute" do
      user.should respond_to(:password_confirmation)
    end
  end
  
  describe "password validations" do

    it "should require a password" do
      User.new(@attr.merge(:password => "", :password_confirmation => "")).
        should_not be_valid
    end

    it "should require a matching password confirmation" do
      User.new(@attr.merge(:password_confirmation => "invalid")).
        should_not be_valid
    end
    
    it "should reject short passwords" do
      short = "a" * 5
      hash = @attr.merge(:password => short, :password_confirmation => short)
      User.new(hash).should_not be_valid
    end
    
  end
  
  describe "password encryption" do
    
    before(:each) do
      @user = User.create!(@attr)
    end
    
    it "should have an encrypted password attribute" do
      @user.should respond_to(:encrypted_password)
    end

    it "should set the encrypted password attribute" do
      @user.encrypted_password.should_not be_blank
    end

  end

end
=end
