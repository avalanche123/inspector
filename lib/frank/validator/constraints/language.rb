module Frank
  module Validator
    module Constraints
      class Language
        include Validator::Constraint

        set :message, "This value is not a valid language."
      end
    end
  end
end