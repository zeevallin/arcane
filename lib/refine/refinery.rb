module Refine

  class Refinery

    attr_reader :object, :user

    def initialize(object,user=nil)
      @object = object
      @user   = user
    end

    def default
      []
    end

  end

end
