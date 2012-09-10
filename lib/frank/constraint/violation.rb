module Frank
  module Constraint
    class Violation
      autoload :List, 'frank/constraint/violation/list'

      attr_reader :property_path, :value, :constraint

      def initialize(property_path, value, constraint)
        @property_path = property_path
        @value = value
        @constraint = constraint
      end

      def to_s
        "#{@property_path} #{@constraint}".lstrip
      end
    end
  end
end