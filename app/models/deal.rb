class Deal < ActiveRecord::Base
  validates_presence_of :title
  scope :current, lambda{ where("Date(start_date) <= ? AND Date(end_date) >= ?", Date.today.to_date, Date.today.to_date)}
end
