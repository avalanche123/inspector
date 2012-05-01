module Frank
  module Validator
    module Constraints
      class Nil
        include Validator::Constraint

        set :message, "This value should be nil."
      end
    end
  end
end