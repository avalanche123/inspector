module Frank
  module Validation
    module Constraints
      class Nil
        include Validation::Constraint

        set :message, "This value should be nil."
      end
    end
  end
end