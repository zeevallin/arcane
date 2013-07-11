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

    current_user = nil unless respond_to?(:current_user)

    opts = { }

    args.each do |arg|
      if [String,Symbol].any? { |c| arg.kind_of?(c) }
        opts[:method] ||= arg
      elsif [Hash,HashWithIndifferentAccess,ActionController::Parameters].any? { |c| arg.kind_of?(c) }
        opts[:params] ||= arg
      elsif current_user.nil?
        opts[:user]   ||= arg
      end
    end

    opts[:method] ||= params[:action]
    opts[:params] ||= params
    opts[:user]   ||= current_user
    opts[:object] ||= object.respond_to?(:new) ? object.new : object

    chain = Arcane::Chain.new(opts[:params],opts[:object],opts[:user])
    return opts[:method].present? ? chain.send(opts[:method]) : chain
  end

end
