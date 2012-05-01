module Frank
  module Validation
    module Constraints
      class Callback
        include Validation::Constraint

        default_option :method
        required_options :method
      end
    end
  end
end