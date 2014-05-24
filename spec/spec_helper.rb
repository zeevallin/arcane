require 'coveralls'

Coveralls.wear!

require "arcane"
require "pry"
require "active_support/core_ext"
require "active_model/naming"

RSpec.configure do |c|
  c.before :suite do
    ActiveSupport::Deprecation.silenced = true
  end
end

class NilModel; end
class NilModelRefinery < Struct.new(:object,:user)

  def create
    [:attribute]
  end

  def default
    create
  end

end

class Article; end
class ArticleRefinery < Arcane::Refinery

  def create
    update + [ { links: [:blog, :site] } ]
  end

  def publish
    update + [ { tags: [] } ]
  end

  def update
    default + [:content]
  end

  def default
    [:title]
  end

end

class Task; end
class TaskRefinery < Arcane::Refinery

  def self.root
    false
  end

end

class Shape; end

class Comment; end
class CommentRefinery < Arcane::Refinery

  def create
    [:content,:score]
  end

  def default
    [:score]
  end

end

def article_params
  ActionController::Parameters.new({
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

def nil_model_params(opts={})
  ActionController::Parameters.new({
    action: 'unknown',
    nil_model: { attribute: :value }
  }).merge(opts)
end

def expected_params(object_name,*includes)
  params[object_name].reject { |k,_| !includes.include? k.to_sym }
end
