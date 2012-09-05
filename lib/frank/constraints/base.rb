module Frank
  module Constraints
    class Base
      def validate(value, violations, property_path)
        violations << Constraint::Violation.new(property_path, value, self) unless valid?(value)
      end
    end
  end
end