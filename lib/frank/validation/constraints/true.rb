module Frank
  module Validation
    module Constraints
      class True
        include Validation::Constraint

        set :message, "This value should be true."
      end
    end
  end
end