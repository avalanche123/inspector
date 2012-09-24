module Inspector
  module Constraint
    module Validators
      class Simple
        def validate(value, constraint, violations_list)
          if constraint.positive? ^ constraint.valid?(value)
            violations_list << Constraint::Violation.new(constraint)
          end
        end
      end
    end
  end
end