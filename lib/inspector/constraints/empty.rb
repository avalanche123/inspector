module Inspector
  module Constraints
    class Empty
      include Constraint

      def valid?(actual)
        actual = actual.to_s unless actual.respond_to?(:empty?)

        actual.empty?
      end

      def to_s
        "be_empty"
      end

      def inspect
        "#<empty>"
      end
    end
  end
end