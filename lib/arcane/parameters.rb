module Arcane

  module Parameters

    extend ActiveSupport::Concern

    included do

      attr_accessor :user, :object, :action

      def dup
        self.class.new(self).tap do |duplicate|
          duplicate.user    = user
          duplicate.object  = object
          duplicate.action  = action
          duplicate.default = default
          duplicate.instance_variable_set :@permitted, @permitted
        end
      end

    end

    def for(object)
      params = self.dup
      params.object = object
      return params
    end

    def as(user)
      params = self.dup
      params.user = user
      return params
    end

    def on(action)
      params = self.dup
      params.action = action
      return params
    end

    def refine(opts={})
      params = self.dup

      params.action = opts[:action] || action || params[:action]
      params.user   = opts[:user]   || user
      params.object = opts[:object] || object

      refinery = Arcane::Finder.new(params.object).refinery.new(params.object, params.user)

      args = if params.action.nil?
        []
      elsif refinery.respond_to?(params.action)
        refinery.public_send(params.action)
      elsif refinery.respond_to?(:default)
        refinery.default
      else
        []
      end

      root = if refinery.respond_to?(:root)
        refinery.root
      elsif refinery.class.respond_to?(:root)
        refinery.class.root
      else
        Arcane::Finder.object_name(params.object)
      end

      return root.present? ? params.require(root.underscore).permit(*args) : params.permit(*args)

    end

  end


end

ActionController::Parameters.send :include, Arcane::Parameters