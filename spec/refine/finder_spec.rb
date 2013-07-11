require 'spec_helper'

describe Refinery::Finder do

  let(:object_with_refinery) { Task.new }
  let(:object_without_refinery) { Shape.new }

  before(:each) { @refinery = Refinery::Finder.new(object_with_refinery) }

  describe '.new' do
    it 'sets the object' do
      @refinery.object.should eq(object_with_refinery)
    end
  end

  describe '#find' do

    it 'finds existing refinery' do
      @refinery.send(:find).should eq "TaskRefinery"
    end

  end

  describe '#refinery' do

    it 'returns refinery' do
      @refinery.refinery.should eq TaskRefinery
    end

    it 'returns base refinery class when no refinery exists' do
      @refinery = Refinery::Finder.new(object_without_refinery)
      @refinery.refinery.should eq Refinery::Base
    end

  end

end