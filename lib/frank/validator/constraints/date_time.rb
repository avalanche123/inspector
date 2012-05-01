module Frank
  module Validator
    module Constraints
      class DateTime
        include Validator::Constraint

        set :message, "This value is not a valid datetime."
      end
    end
  end
end