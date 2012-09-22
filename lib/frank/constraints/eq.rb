module Frank
  module Constraints
    class Eq
      def initialize(expected)
        @expected = expected
      end

      def valid?(actual)
        actual == @expected
      end

      def to_s
        "eq"
      end

      def inspect
        "#<== #{@expected.inspect}>"
      end
    end
  end
end