module Frank
  module Constraints
    class Eq < Base
      def initialize(expected)
        @expected = expected
      end

      def valid?(actual)
        actual == @expected
      end

      def inspect
        "should == #{@expected.inspect}"
      end
    end
  end
end