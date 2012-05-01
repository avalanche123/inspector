module Frank
  module Validation
    module Constraints
      class Time
        include Validation::Constraint

        set :message, "This value is not a valid time."
      end
    end
  end
end