module Frank
  module Constraint
    class Violation
      autoload :List, 'frank/constraint/violation/list'

      attr_reader :constraint

      def initialize(positive, constraint)
        @positive = positive
        @constraint = constraint
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
        "#<violation constraint=#{@constraint.inspect}, positive=#{@positive.inspect}>"
      end
    end
  end
end