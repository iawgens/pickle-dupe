require File.expand_path(File.join(File.dirname(__FILE__), '../spec_helper'))

describe PickleDupe::Session do
  describe "after storing a single user", :shared => true do
    it "created_models('user') should be array containing the original user" do
      created_models('user').should == [@user]
    end

    describe "the original user should be retrievable with" do
      it "created_model('the user')" do
        created_model('the user').should == @user
      end

      it "created_model('1st user')" do
        created_model('1st user').should == @user
      end

      it "created_model('last user')" do
        created_model('last user').should == @user
      end
    end

    describe "(found from db)" do
      before do
        @user.stub!(:id).and_return(100)
        @user.class.should_receive(:find).with(100).and_return(@user_from_db = @user.dup)
      end
    
      it "models('user') should be array containing user" do
        models('user').should == [@user_from_db]
      end
  
      describe "user should be retrievable with" do
        it "model('the user')" do
          model('the user').should == @user_from_db
        end

        it "model('1st user')" do
          model('1st user').should == @user_from_db
        end

        it "model('last user')" do
          model('last user').should == @user_from_db
        end
        
        it "model!('last user')" do
          model('last user').should == @user_from_db
        end
      end
    end
  end
  
  describe "#create_model" do
    before do
      @user = mock_model(User)
      Factory.stub!(:create).and_return(@user)
    end
    
    describe "('a user')" do
      def do_create_model
        create_model('a user')
      end
  
      it "should call Factory.create('user', {})" do
        Factory.should_receive(:create).with('user', {}).and_return(@user)
        do_create_model
      end
      
      describe "after create," do
        before { do_create_model }
        
        it_should_behave_like "after storing a single user"
      end
    end
    
    describe "('1 user', 'foo: \"bar\", baz: \"bing bong\"')" do
      def do_create_model
        create_model('1 user', 'foo: "bar", baz: "bing bong"')
      end
  
      it "should call Factory.create('user', {'foo' => 'bar', 'baz' => 'bing bong'})" do
        Factory.should_receive(:create).with('user', {'foo' => 'bar', 'baz' => 'bing bong'}).and_return(@user)
        do_create_model
      end
      
      describe "after create," do
        before { do_create_model }
        
        it_should_behave_like "after storing a single user"
      end
    end  

    describe "('an user: \"fred\")" do
      def do_create_model
        create_model('an user: "fred"')
      end
  
      it "should call Factory.create('user', {})" do
        Factory.should_receive(:create).with('user', {}).and_return(@user)
        do_create_model
      end
      
      describe "after create," do
        before { do_create_model }
        
        it_should_behave_like "after storing a single user"
              
        it "created_model('the user: \"fred\"') should retrieve the user" do
          created_model('the user: "fred"').should == @user
        end
      
        it "created_model?('the user: \"shirl\"') should be false" do
          created_model?('the user: "shirl"').should == false
        end
        
        it "model?('the user: \"shirl\"') should be false" do
          model?('the user: "shirl"').should == false
        end
      end
    end
    
    describe "with hash" do
      def do_create_model
        create_model('a user', {'foo' => 'bar'})
      end
  
      it "should call Factory.create('user', {'foo' => 'bar'})" do
        Factory.should_receive(:create).with('user', {'foo' => 'bar'}).and_return(@user)
        do_create_model
      end
      
      describe "after create," do
        before { do_create_model }
        
        it_should_behave_like "after storing a single user"
      end
    end
    
  end

  describe '#find_model' do
    before do
      @user = mock_model(User)
      User.stub!(:find).and_return(@user)
    end
    
    def do_find_model
      find_model('a user', 'hair: "pink"')
    end
    
    it "should call User.find :first, :conditions => {'hair' => 'pink'}" do
      User.should_receive(:find).with(:first, :conditions => {'hair' => 'pink'}).and_return(@user)
      do_find_model
    end
    
    describe "after find," do
      before { do_find_model }
      
      it_should_behave_like "after storing a single user"
    end
    
    describe "with hash" do
      def do_create_model
        find_model('a user', {'foo' => 'bar'})
      end
  
      it "should call User.find('user', {'foo' => 'bar'})" do
        User.should_receive(:find).with(:first, :conditions => {'foo' => 'bar'}).and_return(@user)
        do_create_model
      end
      
      describe "after find," do
        before { do_find_model }
        
        it_should_behave_like "after storing a single user"
      end
    end
  end
  
  describe "#find_model!" do
    it "should call find_model" do
      should_receive(:find_model).with('name', 'fields').and_return(mock('User'))
      find_model!('name', 'fields')
    end

    it "should call raise error if find_model returns nil" do
      should_receive(:find_model).with('name', 'fields').and_return(nil)
      lambda { find_model!('name', 'fields') }.should raise_error
    end
  end
  
  describe "#find_models" do
end
