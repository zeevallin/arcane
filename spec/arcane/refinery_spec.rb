require 'spec_helper'

describe Arcane::Refinery do

  let(:user) { double }
  let(:object) { Article.new }

  before(:each) do
    @arcane = Arcane::Refinery.new(object,user)
  end

  describe '.new' do

    it 'sets attributes' do
      @arcane.object.should eq(object)
      @arcane.user.should eq(user)
    end

    it 'does not set user if no user present' do
      @arcane = Arcane::Refinery.new(object)
      @arcane.user.should be_nil
    end

  end

  describe '#default' do

    it { @arcane.default.should be_empty }

    it 'can be overridden when inherited' do
      @arcane = ArticleRefinery.new(object,user)
      @arcane.default.should eq [:title]
    end

  end

end