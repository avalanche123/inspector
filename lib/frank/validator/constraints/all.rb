module Frank
  module Validator
    module Constraints
      class All
        include Validator::Constraint

        default_option :constraints
        required_options :constraints
      end
    end
  end
end