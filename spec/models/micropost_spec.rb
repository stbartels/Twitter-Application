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
end
