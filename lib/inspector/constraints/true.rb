module Inspector
  module Constraints
    class True
      include Constraint

      def valid?(actual)
        !!actual
      end

      def to_s
        "be_true"
      end

      def inspect
        "#<true>"
      end
    end
  end
end