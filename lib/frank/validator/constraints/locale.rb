module Frank
  module Validator
    module Constraints
      class Locale
        include Validator::Constraint

        set :message, "This value is not a valid locale."
      end
    end
  end
end