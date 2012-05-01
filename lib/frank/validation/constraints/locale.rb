module Frank
  module Validation
    module Constraints
      class Locale
        include Validation::Constraint

        set :message, "This value is not a valid locale."
      end
    end
  end
end