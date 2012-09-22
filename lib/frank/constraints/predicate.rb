module Frank
  module Constraints
    class Predicate
      def initialize(method, *args, &block)
        @method = method
        @args = args
        @block = block
      end

      def valid?(actual)
        actual.__send__("#{@method}?", *@args, &@block)
      rescue NameError
        @method = "#{@method}s"
        actual.__send__("#{@method}?", *@args, &@block)
      end

      def to_s
        "be_#{@method}"
      end

      def inspect
        "#<#{@method}>"
      end
    end
  end
end