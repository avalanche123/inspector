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
        "equal #{@expected.inspect}"
      end

      def inspect
        "#<#{self.class.inspect}:#{'0x00%x' % (__id__ << 1)} expected=#{@expected.inspect}>"
      end
    end
  end
end