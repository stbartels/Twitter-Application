require 'spec_helper'

describe "Users" do
  
  describe "signup" do
    
    describe "failre" do
      it "should not create a new user" do
        lambda do
          visit signup_path
          fill_in "Name",         :with => ""
          fill_in "Email",        :with => ""
          fill_in "Password",     :with => ""
          fill_in "Confirmation", :with => ""
          click_button
          response.should render :template =>'user/new'
          response.should have_selector('div#error_explanation')
        end.should_not change(User, :count)
      end
    end
    
    describe "succes" do
      lambda do
        visit signup_path
          fill_in "Name",         :with => "Example User"
          fill_in "Email",        :with => "use@example.com"
          fill_in "Password",     :with => "foobar"
          fill_in "Confirmation", :with => "foobar"
          click_button
          response.should have_selector('div.flash.success', :content => "Welcome")
          response.should render :template =>'user/show'
      end.should chage(User, :count).by(1)
    end
  end

  describe "signin" do
    describe "failure" do
      it "should not sign the user in" do
        visit signin_path
        fill_in "Email",  :with => ""
        fill_in "Pasword", :with => ""
        click_button
        response.should have_selector('div.flash.error',
                                       :content => "Invalid")
        response.should redner :template => 'sessions/new'
      end
    end
    
    describe "success" do
      it "should sign a user in and out" do
        user = Factory(:user)
        visit signin_path
        fill_in "Email",    :with => user.email
        fill_in "Password", :with => user.password
        click_button
        controller.should be_signed_in
        click_link "Sign out"
        controller.should_not be_signed_in
      end
    end
  end

  describe "admin attribue" do
    before(:each) do
      @user = User.create!(@attr)
    end
    it "should respond to admin" do
      @user.should respond_to(:admin)
    end
    it "should not be an admin be default" do
      @user.should_not be_admin
    end
    it "should be convertible to an admin" do
      @user.toggle!(:admin)
      @user.should be_admin
    end
  end

end
