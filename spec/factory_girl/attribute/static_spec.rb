require 'spec_helper'

describe FactoryGirl::Attribute::Static do
  before do
    @name  = :first_name
    @value = 'John'
    @attr  = FactoryGirl::Attribute::Static.new(@name, @value)
  end

  it "should have a name" do
    @attr.name.should == @name
  end

  it "should set its static value on a proxy" do
    @proxy = stub("proxy", :set => nil)
    @attr.add_to(@proxy)
    @proxy.should have_received(:set).with(@name, @value)
  end

  it "should raise an error when defining an attribute writer" do
    lambda {
      FactoryGirl::Attribute::Static.new('test=', nil)
    }.should raise_error(FactoryGirl::AttributeDefinitionError)
  end

  it "should convert names to symbols" do
    FactoryGirl::Attribute::Static.new('name', nil).name.should == :name
  end
end
