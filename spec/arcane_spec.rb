require 'spec_helper'

describe Arcane do

  let(:user)    { double }
  let(:article) { Article.new }
  let(:comment) { Comment.new }
  let(:controller) { double(:current_user => user, :params => params).tap { |c| c.extend(Arcane) } }
  let(:params) do
    HashWithIndifferentAccess.new({
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

    context 'without supplying a refinery method' do

      let(:params) do
        HashWithIndifferentAccess.new({
          action: 'create',
          comment: {
           content: "Awesome!",
           score: 5
          }
        })
      end

      it 'still returns a parameters hash' do
        controller.refine(comment).should be_a ActionController::Parameters
      end

      it 'finds the right method' do
        controller.refine(comment).should eq expected_params(:comment,:score,:content)
      end

      context 'using a missing refinery method' do

        let(:params) do
          HashWithIndifferentAccess.new({
            action: 'update',
            comment: {
             content: "Awesome!",
             score: 5
            }
          })
        end

        it 'falls back on default' do
          controller.refine(comment).should eq expected_params(:comment,:score)
        end

      end

    end

    it 'filters parameters correctly' do
      controller.refine(article).update.should eq expected_params(:article,:title,:content)
    end

    it 'filters nested object parameters correctly' do
      controller.refine(article).create.should eq expected_params(:article,:title,:content,:links)
    end

    it 'filters nested scalar parameters correctly' do
      controller.refine(article).publish.should eq expected_params(:article,:title,:content,:tags)
    end

    it 'filters custom parameters correctly' do
      controller.refine(article,custom_params,:publish).should eq expected_params(:article,:tags)
      controller.refine(article,:publish,custom_params).should eq expected_params(:article,:tags)
    end

  end

end

def expected_params(object_name,*includes)
  params[object_name].reject { |k,_| !includes.include? k.to_sym }
end