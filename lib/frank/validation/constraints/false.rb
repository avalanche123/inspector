module Frank
  module Validation
    module Constraints
      class False
        include Validation::Constraint

        set :message, "This value should be false."
      end
    end
  end
end