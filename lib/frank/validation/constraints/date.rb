module Frank
  module Validation
    module Constraints
      class Date
        include Validation::Constraint

        set :message, "This value is not a valid date."
      end
    end
  end
end