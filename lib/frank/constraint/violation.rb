module Frank
  module Constraint
    class Violation
      autoload :List, 'frank/constraint/violation/list'

      def initialize(property_path, value, constraint)
        @property_path = property_path
        @value = value
        @constraint = constraint
      end

      def inspect
        "#{@property_path} #{@constraint.inspect}"
      end
    end
  end
end