require File.expand_path(File.join(File.dirname(__FILE__), '../spec_helper'))

describe Pickle::Config do
  before do
    @config = Pickle::Config.new
  end
  
  describe "setting adapters to :dupe" do
    before do
      @config.adapters = [:dupe]
    end
   
    it "#adapter_classes should be Adapter::Dupe" do
      @config.adapter_classes.should == [Pickle::Adapter::Dupe]
    end 
  end
  
end