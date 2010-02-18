require File.expand_path(File.join(File.dirname(__FILE__), '../spec_helper'))

describe PickleDupe::Adapter do
  describe "Adapter::Dupe" do
    before do
      @klass1 = returning(Class.new(ActiveResource::Base)) {|k| k.stub!(:name).and_return('One')}
      @klass2 = returning(Class.new(ActiveResource::Base)) {|k| k.stub!(:name).and_return('One::Two')}
      @klass3 = returning(Class.new(ActiveResource::Base)) {|k| k.stub!(:name).and_return('Three')}

      Pickle::Adapter::Dupe.stub!(:model_classes).and_return([@klass1, @klass2, @klass3])
      @orig_models, Dupe.models = Dupe.models, {}
      
      @factory1 = Dupe.define(:one)
      @factory2 = Dupe.define(:two)
    end
    
    it ".factories should create one for each factory" do
      Pickle::Adapter::Dupe.should_receive(:new).with(@factory1).once
      Pickle::Adapter::Dupe.should_receive(:new).with(@factory2).once
      Pickle::Adapter::Factory.factories
    end
    
    describe ".new(factory)" do
      before do
        @factory = Pickle::Adapter::Dupe.new(@factory1)
      end
      
      it "should have name of factory name" do
        @factory.name.should == "one"
      end
      
      it "should have klass of build_class" do
        @factory.klass.should == @klass1
      end
      
      it "#create(attrs) should call Factory(:key,attrs)" do
        ::Dupe.should_receive(:create).with("one", {:key => "val"})
        @factory.create(:key => "val")
      end
      
    end

  end
end
    
