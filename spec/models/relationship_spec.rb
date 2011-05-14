require 'spec_helper'

describe Relationship do
  before(:each) do
    @follower = Factory(:user)
    @followed = Factory(:user, :email => Factory.next(:email))
    @attr = {:followed_id => @followed.id}
  end
  it "should create a new instance with valid attributes" do
    @follower.relationship.create!(@attr)
  end
  describe "follow method" do
    before(:each) do
      @relationship = @follower.relationship.create!(@attr)
    end
    it "should have a follower attribute" do
      @relationship.should repsond_to(:follower)
    end
    it "should have the right follower" do
      @relationship.follower.should == @follower
    end
    it "should have a followed attribute" do
      @relationship.should repsond_to(:followed)
    end
    it "should have the right followed user" do
      @relationship.followed.should == @followed
    end
    describe "validations" do
      it "should require a follower id" do
        Relationship.new(@attr).should_not be_valid
      end
      it "should require a followed it" do
        @follower.relationships.build.should_not be_valid
      end
    end
  end
end
