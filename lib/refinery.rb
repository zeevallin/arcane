require "refinery/version"
require "refinery/finder"
require "refinery/chain"
require "refinery/base"

require 'active_support/concern'
require 'active_support/core_ext/string/inflections'
require 'active_support/core_ext/object/blank'
require 'strong_parameters'

module Refinery

  extend ActiveSupport::Concern

  included do
    if respond_to?(:helper_method)
      helper_method :refinery
    end
    if respond_to?(:hide_action)
      hide_action :refinery
    end
  end

  def refine(object,*args)
    Refinery::Chain.new(params,object,current_user)
  end

end
