require 'spec_helper'

describe HomeController do
  describe "GET #index" do

    context "when not logged in" do
      it "should redirect to new session" do
        get 'index'
        response.should redirect_to(new_session_url)
      end
    end
    
    context "when logged in" do
      before(:each) do 
        @user = FactoryGirl.generate(:user)
        puts "WTFF"
        p @user.name
        p "WFT"
        log_in(@user)
      end
      
      it "should get index" do
        get 'index'
        response.should be_success
      end
    end
  end
end
