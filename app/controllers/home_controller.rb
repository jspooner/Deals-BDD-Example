class HomeController < ApplicationController
  def index
    @users = User.all
    @deals = Deal.current
  end
end
