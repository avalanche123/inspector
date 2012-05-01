module Frank
  module Validation
    module Constraints
      class Empty
        include Validation::Constraint

        set :message, "This value should be empty."
      end
    end
  end
end