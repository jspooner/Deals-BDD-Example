require 'spec_helper'

describe Deal do
  it { Deal.new.number_sold.should eql(0) }
  it { Deal.new.quantity.should eql(0) }
end
