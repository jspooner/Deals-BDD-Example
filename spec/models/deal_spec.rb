require 'spec_helper'

describe Deal do
  describe "init" do
    it { Deal.new.number_sold.should eql(0) }
    it { Deal.new.quantity.should eql(0) }
  end
  describe "validation" do
    it { Deal.new.should have(1).errors_on(:title) }    
  end
  describe "queries" do
    before(:each) do
      @past    = Factory(:deal, { :start_date => 30.days.ago, :end_date => 29.days.ago })
      @current = Factory(:deal, { :start_date => 5.days.ago, :end_date => 5.days.from_now })
      @future  = Factory(:deal, { :start_date => 5.days.from_now, :end_date => 10.days.from_now })
    end
    it "should find current deals" do
      deals = Deal.current
      deals.should have(1).item
      deals.first.should eql(@current)
    end
  end
end