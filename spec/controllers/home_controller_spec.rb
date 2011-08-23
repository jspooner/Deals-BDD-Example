require 'spec_helper'

describe HomeController do

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
    it "should set the current deals" do
      deal = Factory(:deal)
      get :index
      assigns(:deals).should eq([deal])
    end
  end

end
