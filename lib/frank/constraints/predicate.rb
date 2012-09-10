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
        @args.size > 0 ? ".#{@method}?(#{@args.map(&:inspect).join(", ")})" : ".#{@method}?"
      end

      def inspect
        "#<#{self.class.inspect}:#{'0x00%x' % (__id__ << 1)} method=\"#{@method}?\">"
      end
    end
  end
end