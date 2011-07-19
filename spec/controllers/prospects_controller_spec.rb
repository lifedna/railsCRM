require 'spec_helper'

describe ProspectsController do

  before(:each)  do
    @prospect1 = Factory(:prospect)
    @prospect2 = Factory(:prospect)
  end

  describe "Index Action" do
    it "should check index" do
      get :index
      #assigns[:prospects].should be_kind_of(Enumerator)
      assigns[:prospects].should have(2).items
      response.should render_template('index')
    end
  end

  describe "New Action" do
    it "should check new" do
      get :new
      assigns[:prospect].should be_instance_of(Prospect)
      assigns[:prospect].should be_new_record
      response.should render_template('new')
    end
  end

  describe "Create Action" do
    it "should check create if successful" do
      post :create, :prospect => {:first_name => "Sachin", :last_name => "Singh",
        :date_of_birth => Date.today - 24.years,
        :gender => 'Male'}
      assigns[:prospect].should_not be_new_record
      assigns[:prospect].should be_valid
      assigns[:prospect].should be_instance_of(Prospect)
      flash[:notice].should == "Prospect is created successfully."
      response.should redirect_to prospects_path
    end
  
    it "should check create if unsuccessful" do
      post :create, :prospect => {:first_name => "", :last_name => "",
        :date_of_birth => Date.today - 24.years,
        :gender => 'Male'}
      assigns[:prospect].should be_new_record
      assigns[:prospect].should be_instance_of(Prospect)
      assigns[:prospect].should_not be_valid
      flash[:error].should == "Error while creating Prospect."
      response.should render_template('new')
    end
  end

  describe "Update Action" do
    it "should check update if successful" do
      put :update, :id => @prospect1.id , :prospect => {:first_name => "Saurav", :last_name => "Ganguly" }
      assigns[:prospect].should be_instance_of(Prospect)
      assigns[:prospect].should_not be_new_record
      assigns[:prospect].should be_valid
      assigns[:prospect].full_name.should == "Saurav Ganguly"
      flash[:notice].should == "Successfully updated #{assigns[:prospect].full_name}"
      response.should redirect_to prospects_path
    end

    it "should check update if unsuccessful" do
      put :update, :id => @prospect1.id , :prospect => {:first_name => "", :last_name => "" }
      assigns[:prospect].should be_instance_of(Prospect)
      assigns[:prospect].should_not be_new_record
      assigns[:prospect].should_not be_valid
      flash[:error].should == "Error while updating prospect."
      response.should render_template('edit')
    end
  end

  describe "Show Action" do
    it "should check show" do
      get :show, :id => @prospect1.id
      assigns[:prospect].should_not be_new_record
      assigns[:prospect].should be_instance_of(Prospect)
      response.should render_template('show')
    end
  end

  describe "Destroy Action" do
    it "should check destroy if successful" do
      delete :destroy, :id => @prospect2.id
      assigns[:prospect].should be_frozen
      flash[:notice].should == "Successfully deleted prospect."
      response.should redirect_to prospects_path
    end
  end
end