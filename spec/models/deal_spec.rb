require 'spec_helper'

describe Deal do
  describe "init" do
    it { Deal.new.number_sold.should eql(0) }
    it { Deal.new.quantity.should eql(0) }
  end
  describe "validation" do
    it { Deal.new.should have(1).errors_on(:title) }    
  end
end
