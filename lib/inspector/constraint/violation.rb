module Inspector
  module Constraint
    class Violation
      autoload :List, 'inspector/constraint/violation/list'

      attr_reader :constraint

      def initialize(constraint, positive)
        @constraint = constraint
        @positive = positive
      end

      def positive?
        @positive
      end

      def negative?
        !@positive
      end

      def to_s
        expectation = @positive ? 'should' : 'should_not'

        "#{expectation}.#{@constraint}"
      end

      def inspect
        "#<violated %{type} constraint %{constraint}>" % {
          :type       => @positive ? 'positive' : 'negative',
          :constraint => @constraint.inspect
        }
      end
    end
  end
end