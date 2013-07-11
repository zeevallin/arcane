require 'spec_helper'

describe Refine do

  let(:user)    { double }
  let(:article) { Article.new }
  let(:refine)  { Refine.refine() }
  let(:controller) { double(:current_user => user, :params => params).tap { |c| c.extend(Refine) } }
  let(:params) do
    HashWithIndifferentAccess.new({
      action: 'create',
      article: {
        title:   "hello",
        content: "world",
        links: [
          { blog: "http://blog.example.com" },
          { site: "http://www.example.com" },
        ],
        tags: ["test","greeting"]
      }
    })
  end

  describe '#refine' do

    it { controller.refine(article).should be_a Refine::Chain }
    it { controller.refine(article).update.should be_a ActionController::Parameters }

    it 'filters parameters correctly' do
      controller.refine(article).update.should eq expected_params(:title,:content)
    end

    it 'filters nested object parameters correctly' do
      controller.refine(article).create.should eq expected_params(:title,:content,:links)
    end

    it 'filters nested scalar parameters correctly' do
      controller.refine(article).publish.should eq expected_params(:title,:content,:tags)
    end

  end

end

def expected_params(*includes)
  params[:article].reject { |k,_| !includes.include? k.to_sym }
end