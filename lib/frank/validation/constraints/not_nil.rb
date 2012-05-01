module Frank
  module Validation
    module Constraints
      class NotNil
        include Validation::Constraint

        set :message, "This value should not be nil."
      end
    end
  end
end