module Frank
  module Validation
    module Constraints
      class Language
        include Validation::Constraint

        set :message, "This value is not a valid language."
      end
    end
  end
end