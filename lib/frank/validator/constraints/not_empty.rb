module Frank
  module Validator
    module Constraints
      class NotEmpty
        include Validator::Constraint

        set :message, "This value cannot be empty."
      end
    end
  end
end