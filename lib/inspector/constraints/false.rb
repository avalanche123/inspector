module Inspector
  module Constraints
    class False
      include Constraint

      def valid?(actual)
        !actual
      end

      def to_s
        "be_false"
      end

      def inspect
        "#<false>"
      end
    end
  end
end