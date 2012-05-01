module Frank
  module Validator
    module Constraints
      class MaxLength
        include Validator::Constraint

        set :message, "This value is too long. It should have %{limit} characters or less."
        set :charset, "utf8"

        default_option :limit
        required_options :limit
      end
    end
  end
end