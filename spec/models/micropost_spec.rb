require 'spec_helper'

describe Micropost do
  before(:each) do
    @user = Factory(:user)
    @attr = {:content => "larem ipsum"}
  end
  it "should create new instance with valid attributes" do
    @user.microposts.create!(@attr)
  end
  describe "user associations" do
    before(:each) do
      @mircopost = @user.microposts.create(@attr)
    end
    it "should have a user attribute" do
      @micropost.should respond_to(:user)
    end
    it "should have the right associated user" do
      @micropost.user_id.should == @user.id
      @mircopost.user.should == @user
    end
  end
  describe "validations" do
    it "should have user id" do
      Mircopost.new(@attr).should_not be_valid
    end
    it "should require nonblank content" do
      @user.micropost.build(:content => "  ").should_not be_valid
    end
    it "should reject long content" do
      @user.micropost.build(:content => 'a' * 141).should_not be_valid
    end
  end
end
