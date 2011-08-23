class HomeController < ApplicationController
  def index
    @users = User.all
    @deals = Deal.where("Date(start_date) <= ? AND Date(end_date) >= ?", Date.today.to_date, Date.today.to_date)
  end
end
