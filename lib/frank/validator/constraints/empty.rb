module Frank
  module Validator
    module Constraints
      class Empty
        include Validator::Constraint

        set :message, "This value should be empty."
      end
    end
  end
end