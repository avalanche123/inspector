module Inspector
  module Constraint
    class Violation
      autoload :List, 'inspector/constraint/violation/list'

      attr_reader :constraint

      def initialize(constraint)
        @constraint = constraint
      end

      def positive?
        @constraint.positive?
      end

      def negative?
        !@constraint.positive?
      end

      def to_s
        expectation = @constraint.positive? ? 'should' : 'should_not'

        "#{expectation}.#{@constraint}"
      end

      def inspect
        "#<violated %{type} constraint %{constraint}>" % {
          :type       => @constraint.positive? ? 'positive' : 'negative',
          :constraint => @constraint.inspect
        }
      end
    end
  end
end