require "refine/version"
require "refine/finder"
require "refine/chain"
require "refine/refinery"

require 'active_support/concern'
require 'active_support/core_ext/string/inflections'
require 'active_support/core_ext/object/blank'
require 'strong_parameters'

module Refine

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
    Refine::Chain.new(params,object,current_user)
  end

end
