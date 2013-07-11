require 'spec_helper'

describe Refine::Chain do

  let(:chain) { Refine::Chain.new(params,object,user) }

  let(:user)            { double }
  let(:object)          { Article.new }
  let(:refinery_class)  { ArticleRefinery }
  let(:params)          { ActionController::Parameters.new(hash_params) }
  let(:hash_params) do
    {
      article: {
        title:   "hello",
        content: "world",
        links: [
          { blog: "http://blog.example.com" },
          { site: "http://www.example.com" },
        ]
      }
    }
  end

  describe '.new' do

    it 'sets attributes' do
      chain._params.should         eq(params)
      chain._object.should         eq(object)
      chain._user.should           eq(user)
      chain._refinery.should       be_a(refinery_class)
      chain._refinery_class.should eq(refinery_class)
    end

    it 'converts the object to ActionController::Parameters' do
      chain = Refine::Chain.new(hash_params,object,user)
      chain._params.should be_a ActionController::Parameters
    end

  end

  describe '#method_missing' do

    it 'returns the filtered parameters' do
      chain.void_method.should be_a ActionController::Parameters
    end

    it 'filters the same as the default constraint' do
      chain.void_method.should eq chain.default
    end

    context 'without root in params' do
      let(:chain) { Refine::Chain.new(params[:article],object,user) }
      it 'raises an error' do
        expect { chain.void_method }.to raise_error ActionController::ParameterMissing
      end
      it 'successds with nil root in refinery' do
        refinery_class.stub(:root) { false }
        expect { chain.void_method }.to_not raise_error
        refinery_class.stub(:root) { nil }
        expect { chain.void_method }.to_not raise_error
      end
    end

  end

end