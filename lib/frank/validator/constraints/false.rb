module Frank
  module Validator
    module Constraints
      class False
        include Validator::Constraint

        set :message, "This value should be false."
      end
    end
  end
end