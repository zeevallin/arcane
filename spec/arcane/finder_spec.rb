require 'spec_helper'

describe Arcane::Finder do

  let(:object_with_arcane) { Task.new }
  let(:object_without_arcane) { Shape.new }

  before(:each) { @arcane = Arcane::Finder.new(object_with_arcane) }

  describe '.new' do
    it 'sets the object' do
      @arcane.object.should eq(object_with_arcane)
    end
  end

  describe '#find' do

    it 'finds existing arcane' do
      @arcane.send(:find).should eq "TaskRefinery"
    end

  end

  describe '#arcane' do

    it 'returns arcane' do
      @arcane.arcane.should eq TaskRefinery
    end

    it 'returns base arcane class when no arcane exists' do
      @arcane = Arcane::Finder.new(object_without_arcane)
      @arcane.arcane.should eq Arcane::Refinery
    end

  end

end