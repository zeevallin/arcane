module Refinery

  class Finder

    attr_reader :object

    def initialize(object)
      @object = object
    end

    def refinery
      klass = find
      klass = klass.constantize if klass.is_a?(String)
      klass
    rescue NameError
      Refinery::Base
    end

    def self.object_name(object)
      klass = if object.respond_to?(:model_name)
        object.model_name
      elsif object.class.respond_to?(:model_name)
        object.class.model_name
      elsif object.is_a?(Class)
        object
      else
        object.class
      end
      klass.to_s
    end

  private

    def find
      if object.respond_to?(:refinery_class)
        object.refinery_class
      elsif object.class.respond_to?(:refinery_class)
        object.class.refinery_class
      else
        klass = self.class.object_name(object)
        "#{klass}Refinery"
      end
    end

  end

end