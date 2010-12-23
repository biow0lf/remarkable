require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe 'have_default_scope' do
  include ModelBuilder

  before(:each) do
    @model = define_model :product, :published => :boolean do
      default_scope :order => 'created_at DESC'
      default_scope where(:published => true)
    end
  end

  describe 'messages' do

    it 'should contain a description' do
      pending "fails when testing for other versions than activerecord '2.3.3'" do
        matcher = have_default_scope(:where => {:special => true})
        matcher.description.should == 'have a default scope with {:conditions=>{:special=>true}}'
      end
    end

    it 'should set options_match? message' do
      pending "fails when testing for other versions than activerecord '2.3.3'" do      
        matcher = have_default_scope(:where => {:special => true})
        matcher.matches?(@model)
        matcher.failure_message.should == 'Expected default scope with {:conditions=>{:special=>true}}, got [{:order=>"created_at DESC"}, {:conditions=>{:published=>true}}]'
      end
    end

  end

  describe 'matchers' do
    it { should have_default_scope(:order => 'created_at DESC') }
    it { should have_default_scope(:where => { :published => true }) }

    it { should_not have_default_scope(:order => 'created_at ASC') }
    it { should_not have_default_scope(:where => { :published => false }) }
    it { should_not have_default_scope(:where => { :published => true }, :order => 'created_at DESC') }

    describe 'when the model has no default scope' do
      before(:each){ @model = define_model(:task) }
      it { @model.should_not have_default_scope }
    end
  end

  describe 'macros' do
    should_have_default_scope :order => 'created_at DESC'
    should_have_default_scope :where => { :published => true }

    should_not_have_default_scope :order => 'created_at ASC'
    should_not_have_default_scope :where => { :published => false }
    should_not_have_default_scope :where => { :published => true }, :order => 'created_at DESC'
  end
end

