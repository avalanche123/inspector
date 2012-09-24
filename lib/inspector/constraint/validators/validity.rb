module Inspector
  module Constraint
    module Validators
      class Validity
        def initialize(validator)
          @validator = validator
        end

        def validate(value, constraint, violations_list)
          violations = @validator.validate(value, :as => constraint.validate_as(value))

          if constraint.positive?
            violations.violations.each { |violation| violations_list << violation }
            violations.children.each { |path, list| violations_list[path] = list }
          else
            if violations.empty?
              violations_list << Constraint::Violation.new(constraint)
            end
          end
        end
      end
    end
  end
end