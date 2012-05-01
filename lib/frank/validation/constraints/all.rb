module Frank
  module Validation
    module Constraints
      class All
        include Validation::Constraint

        default_option :constraints
        required_options :constraints
      end
    end
  end
end