module Frank
  module Constraints
    class Predicate < Base
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

      def inspect
        "#{@method}?(#{@args.map(&:inspect).join(", ")})"
      end
    end
  end
end