require 'spec_helper'

describe Arcane::Parameters do

  let(:user)   { double }
  let(:object) { NilModel.new }
  let(:action) { :unknown }
  let(:params) { nil_model_params }
  let(:refinery) { NilModelRefinery }

  let(:subject)       { subject_class.new(params).for(object).on(action).as(user) }
  let(:subject_class) { ActionController::Parameters }

  describe '#for' do
    it { subject.for(object).should be_a ActionController::Parameters }
    it { subject.for(object).object.should eq object }
  end

  describe '#as' do
    it { subject.as(user).should be_a ActionController::Parameters }
    it { subject.as(user).user.should eq user }
  end

  describe '#on' do
    it { subject.on(action).should be_a ActionController::Parameters }
    it { subject.on(action).action.should eq action }
  end

  describe '#refine' do

    it { subject.refine.should be_a ActionController::Parameters }

    context 'with exstensive parameters' do

      let(:user)   { double }
      let(:object) { Article.new }
      let(:params) { article_params }

      it 'filters correctly' do
        subject.on(:update).refine.should eq expected_params(:article,:title,:content)
      end

      it 'filters nested object parameters correctly' do
        subject.on(:create).refine.should eq expected_params(:article,:title,:content,:links)
      end

      it 'filters nested scalar parameters correctly' do
        subject.on(:publish).refine.should eq expected_params(:article,:title,:content,:tags)
      end

    end

    context 'action is not set' do

      let(:params)  { nil_model_params action: 'create' }
      let(:subject) { subject_class.new(params).for(object).as(user) }

      it 'uses the params to determine refinery action' do
        NilModelRefinery.any_instance.should_receive :create
        subject.refine
      end

      it 'uses the options to determine refinery action' do
        NilModelRefinery.any_instance.should_receive :create
        subject.refine action: :create
      end

    end

    context 'user is not set' do

      let(:user)      { double(name: :test) }
      let(:subject)   { subject_class.new(params).for(object).on(action) }

      it 'uses user from options' do
        expect(subject).to receive(:user).once
        subject.refine(user: user)
      end

    end

  end

end