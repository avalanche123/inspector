module Frank
  module Validator
    module Constraints
      class Callback
        include Validator::Constraint

        default_option :method
        required_options :method
      end
    end
  end
end