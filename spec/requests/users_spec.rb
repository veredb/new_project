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
  describe "sign in/out" do
      describe "failure" do
          it "should not sign a user in" do
               visit signin_path
               fill_in :email,        :with => ""
               fill_in :password,     :with => ""
               click_button
               response.should have_selector('div.flash.error', :content => "invalid email/password combination")
          end
      end

      describe "success" do
          it "should sign a user in and out" do
               user = Factory(:user)
               visit signin_path
               fill_in :email,        :with => user.email
               fill_in :password,     :with => user.password
               click_button
               controller.should be_signed_in
               click_link "Sign out"
               controller.should_not be_signed_in 
             
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
