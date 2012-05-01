module Frank
  module Validator
    module Constraints
      class Time
        include Validator::Constraint

        set :message, "This value is not a valid time."
      end
    end
  end
end