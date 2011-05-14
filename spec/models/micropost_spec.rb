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
  decribe "from_users_followed_by" do
    before(:each) do
      @other_user = Factory(:user, :email => Factory.next(:email))
      @third_user = Factory(:user, :email => Factory.next(:email))
      
      @user_post = @user.microposts.create!(:content => "Foobar")
      @other_post = @other_user.microposts.create!(:content => "Foobar")
      @third_post = @third_user.microposts.create!(:content => "Foobar")
      
      @user.follow!(@other_user)
    end
    it "should have a from_users_followed_by method" do
      Micropost.should respond_to(:from_users_followed_by)
    end
    it "should include the followed user's microposts" do
      Microposts.from_users_followed_by(@user).should include(@other_post)
    end
    it "should include the user's own microposts" do
       Microposts.from_users_followed_by(@user).should include(@user_post)
    end
    it "should not include an unfollowed user's microposts" do
       Microposts.from_users_followed_by(@user).should_not include(@third_post)
    end
  end
end
