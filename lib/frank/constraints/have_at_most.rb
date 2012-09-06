module Frank
  module Constraints
    class HaveAtMost < Have
      def inspect
        "should have at most #{@expected.inspect}"
      end

      private

      def compare(actual)
        actual <= @expected
      end
    end
  end
end