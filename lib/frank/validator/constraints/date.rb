module Frank
  module Validator
    module Constraints
      class Date
        include Validator::Constraint

        set :message, "This value is not a valid date."
      end
    end
  end
end