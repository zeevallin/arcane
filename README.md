# Arcane

[![Build Status](https://travis-ci.org/cloudsdaleapp/arcane.png?branch=master)](https://travis-ci.org/cloudsdaleapp/arcane)
[![Gem Version](https://badge.fury.io/rb/arcane.png)](http://badge.fury.io/rb/arcane)

Easy to use parameter filter extending [Strong Parameters](https://github.com/rails/strong_parameters).
Arcane provides you with helpers which guide you in leveraging regular Ruby classes and object oriented
design patterns to organise and easily harnass the power of strong parameters in Rails 3 and 4.

Arcane magic is real and reliable, no cheap tricks.
Inspired by [Pundit](https://github.com/elabs/pundit)

## Usage

First of all, include `Arcane` in your controller. This will give you access to the `refine` helper.

```ruby
# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  include Arcane
end
```

Before you can use the `refine` helper, you need a Refinery for the model you want to pass parameters to.
Simply create the directory `/app/refineries` in your Rails project. Create a Refinery your model, in this
case Article. `/app/refineries/article_refinery.rb`. Create a class in that file called `ArticleRefinery`.

Methods defined in the refinery should reflect the controller method for clarity, but can be anything you
want it to be. These methods must return an array containing the same parameters you would otherwise send
to strong parameters.

```ruby
# app/refineries/article_refinery.rb
class ArticleRefinery < Arcane::Refinery
  def create
    [:title] + update
  end
  def update
    [:content]
  end
end
```

Next up, using the `refine` helper. The helper can be called from anywhere in your controller and views
and accepts one parameter, the object for which you want to *refine* the parameters, then followed by
calling the method for what parameters you want.

```ruby
refine(@article).create
```

In context of the controller method it might look something like this:

```ruby
class ArticlesController < ApplicationController

  def create
    @article = Article.new(refine(Article).create)
    @article.save
  end
  
  def update
    @article = Article.find(params[:id])
    @article.update_attributes(refine(@article).create)
  end

end

```

## Features

```ruby
```

## Requirements

Currently this gem is only supported for Rails and with any of these ruby versions:

* ruby-2.0.0
* ruby-1.9.3
* ruby-1.9.2
* jruby-19
* rbx-19

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'arcane'
```

And then execute:

```bash
$ bundle
```

## To-do

* Write rails generators
* List features
* Add Documentation

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
