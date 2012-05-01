module Frank
  module Validation
    module Constraints
      class NotEmpty
        include Validation::Constraint

        set :message, "This value cannot be empty."
      end
    end
  end
end