require 'spec_helper'

describe Arcane do

  let(:user)    { double }
  let(:article) { Article.new }
  let(:controller) { double(:current_user => user, :params => params).tap { |c| c.extend(Arcane) } }
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
  let(:custom_params) do
    HashWithIndifferentAccess.new({
      article: {
        tags: ["test","greeting"]
      }
    })
  end

  describe '#refine' do

    it { controller.refine(article).should be_a Arcane::Chain }
    it { controller.refine(article,:update).should be_a ActionController::Parameters }
    it { controller.refine(article).update.should be_a ActionController::Parameters }
    it { controller.refine(Article)._object.should be_a Article }

    it 'filters parameters correctly' do
      controller.refine(article).update.should eq expected_params(:title,:content)
    end

    it 'filters nested object parameters correctly' do
      controller.refine(article).create.should eq expected_params(:title,:content,:links)
    end

    it 'filters nested scalar parameters correctly' do
      controller.refine(article).publish.should eq expected_params(:title,:content,:tags)
    end

    it 'filters custom parameters correctly' do
      controller.refine(article,custom_params,:publish).should eq expected_params(:tags)
      controller.refine(article,:publish,custom_params).should eq expected_params(:tags)
    end

  end

end

def expected_params(*includes)
  params[:article].reject { |k,_| !includes.include? k.to_sym }
end