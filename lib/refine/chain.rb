module Refine

  class Chain

    attr_reader :_params, :_user, :_object, :_refinery, :_refinery_class

    def initialize(_params,_object,_user)
      @_user           = _user
      @_object         = _object
      @_params         = ActionController::Parameters.new(_params)
      @_refinery_class = Refine::Finder.new(_object).refinery
      @_refinery       = @_refinery_class.new(_object,_user)
    end

    def method_missing(_refinery_method,*args)

      if _refinery.respond_to?(_refinery_method)
        _computed = _refinery.public_send(_refinery_method)
      elsif _refinery.respond_to?(:default)
        _computed = _refinery.default
      else
        _computed = []
      end

      if _refinery.respond_to?(:root)
        _root = refinery.root
      elsif _refinery_class.respond_to?(:root)
        _root = _refinery_class.root
      else
        _root = Refine::Finder.object_name(_object)
      end

      if _root.present?
        _params.require(_root.parameterize).permit(*_computed)
      else
        _params.permit(*_computed)
      end

    end

  end

end