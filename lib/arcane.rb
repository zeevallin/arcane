require "arcane/version"
require "arcane/finder"
require "arcane/chain"
require "arcane/refinery"

require 'active_support/concern'
require 'active_support/core_ext/string/inflections'
require 'active_support/core_ext/object/blank'
require 'strong_parameters'

module Arcane

  extend ActiveSupport::Concern

  included do
    if respond_to?(:helper_method)
      helper_method :refine
    end
    if respond_to?(:hide_action)
      hide_action :refine
    end
  end

  def refine(object,*args)
    Arcane::Chain.new(params,object,current_user)
  end

end
