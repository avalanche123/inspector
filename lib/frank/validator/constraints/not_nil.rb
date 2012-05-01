module Frank
  module Validator
    module Constraints
      class NotNil
        include Validator::Constraint

        set :message, "This value should not be nil."
      end
    end
  end
end