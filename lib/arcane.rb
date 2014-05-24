require 'active_support/concern'
require 'active_support/core_ext/string/inflections'
require 'active_support/core_ext/object/blank'
require 'action_controller'

begin
  require 'strong_parameters'
rescue LoadError
end

require "arcane/version"
require "arcane/finder"
require "arcane/refinery"
require "arcane/parameters"

module Arcane

  extend ActiveSupport::Concern

  included do

    if respond_to?(:helper_method)
      helper_method :refine
      helper_method :current_params_user
    end

    if respond_to?(:hide_action)
      hide_action :refine
      hide_action :current_params_user
    end

  end

  def current_params_user
    _arcane_user = respond_to?(:arcane_user) ? arcane_user : nil
    _current_user = respond_to?(:current_user) ? current_user : nil
    if !_arcane_user && _current_user
      show_deprecation_message
    end
    _arcane_user || _current_user
  end

  def params
    @_params ||= ActionController::Parameters.new(request.parameters).as(current_params_user)
  end

  def params=(val)
    @_params = if Hash === val
                 ActionController::Parameters.new(val).as(current_params_user)
               else
                 val.respond_to?(:as) ? val.as(current_params_user) : val
               end
  end

  private

  def show_deprecation_message
    message = 'Arcane found `current_user` and not found `arcane_user`. Please define `arcane_user` for your refineries. This might not work in future.'
    ActiveSupport::Deprecation.warn message
  end

end
