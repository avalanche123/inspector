module Frank
  module Validation
    module Constraints
      class Country
        include Validation::Constraint

        set :message, "This value is not a valid country."
      end
    end
  end
end