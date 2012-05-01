module Frank
  module Validation
    module Constraints
      class DateTime
        include Validation::Constraint

        set :message, "This value is not a valid datetime."
      end
    end
  end
end