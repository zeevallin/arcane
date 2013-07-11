module Arcane

  class Chain

    attr_reader :_params, :_user, :_object, :_arcane, :_arcane_class

    def initialize(_params,_object,_user)
      @_user           = _user
      @_object         = _object
      @_params         = ActionController::Parameters.new(_params)
      @_arcane_class = Arcane::Finder.new(_object).arcane
      @_arcane       = @_arcane_class.new(_object,_user)
    end

    def method_missing(_arcane_method,*args)

      if _arcane.respond_to?(_arcane_method)
        _computed = _arcane.public_send(_arcane_method)
      elsif _arcane.respond_to?(:default)
        _computed = _arcane.default
      else
        _computed = []
      end

      if _arcane.respond_to?(:root)
        _root = arcane.root
      elsif _arcane_class.respond_to?(:root)
        _root = _arcane_class.root
      else
        _root = Arcane::Finder.object_name(_object)
      end

      if _root.present?
        _params.require(_root.parameterize).permit(*_computed)
      else
        _params.permit(*_computed)
      end

    end

  end

end