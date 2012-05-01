module Frank
  module Validation
    module Constraints
      class MinLength
        include Validation::Constraint

        set :message, "This value is too short. It should have %{limit} characters or less."
        set :charset, "utf8"

        default_option :limit
        required_options :limit
      end
    end
  end
end