module Inspector
  module Constraints
    class Predicate
      include Constraint

      def initialize(method, *args, &block)
        @method = method
        @args = args
        @block = block
      end

      def valid?(actual)
        result = false

        begin
          result = actual.__send__("#{@method}?", *@args, &@block)
        rescue NameError
        end

        begin
          result  = actual.__send__("#{@method}s?", *@args, &@block)
          @method = "#{@method}s"
        rescue NameError
        end

        return result
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