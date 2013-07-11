require 'spec_helper'

describe Refinery::Base do

  let(:user) { double }
  let(:object) { Article.new }

  before(:each) do
    @refinery = Refinery::Base.new(object,user)
  end

  describe '.new' do

    it 'sets attributes' do
      @refinery.object.should eq(object)
      @refinery.user.should eq(user)
    end

    it 'does not set user if no user present' do
      @refinery = Refinery::Base.new(object)
      @refinery.user.should be_nil
    end

  end

  describe '#default' do

    it { @refinery.default.should be_empty }

    it 'can be overridden when inherited' do
      @refinery = ArticleRefinery.new(object,user)
      @refinery.default.should eq [:title]
    end

  end

end