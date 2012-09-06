module Frank
  module Constraints
    class HaveAtLeast < Have
      def inspect
        "should have at least #{@expected.inspect}"
      end

      private

      def compare(actual)
        actual >= @expected
      end
    end
  end
end