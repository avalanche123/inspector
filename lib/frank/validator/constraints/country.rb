module Frank
  module Validator
    module Constraints
      class Country
        include Validator::Constraint

        set :message, "This value is not a valid country."
      end
    end
  end
end