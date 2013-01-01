require 'spec_helper'

describe "Users" do
  describe "signup" do
     describe "failure" do
        before(:each) do
              @attr = { :name => "", :email => "", :password => "",
                        :password_confirmation => "" }
        end
        it "should not make a new user" do
          lambda do
            visit signup_path
            fill_in :user_name,                        :with => @attr[:name]
            fill_in :user_email,                       :with => @attr[:email]
            fill_in :user_password,                    :with => @attr[:password]
            fill_in :user_password_confirmation,  :with => @attr[:password_confirmation]
            click_button
            response.should render_template('users/new')
            response.should have_selector("div#error_explanation")
           end.should_not change(User, :count) 
         end
     end
  
     describe "success" do
        before(:each) do
            @attr = { :name => "New User", :email => "user@example.com", :password => "foobar",
                         :password_confirmation => "foobar" }
        end

        it "should make a new user" do
          lambda do
            visit signup_path
            fill_in :user_name,                        :with => @attr[:name]
            fill_in :user_email,                       :with => @attr[:email]
            fill_in :user_password,                    :with => @attr[:password]
            fill_in :user_password_confirmation,  :with => @attr[:password_confirmation]
            click_button
            response.should have_selector("div.flash.success", :content => "Welcome")
            response.should render_template('users/new')
          end.should change(User, :count).by(1)
        end
     end
     
  end
end
#  describe "GET /users" do
#    it "works! (now write some real specs)" do
#      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
#      get users_index_path
#      response.status.should be(200)
#    end
#  end
