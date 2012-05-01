module Frank
  module Validation
    module Constraints
      class Min
        include Validation::Constraint

        set :message, "This value should be %{limit} or more."
        set :invalid_message, "This value should be a valid number."

        default_option :limit
        required_options :limit
      end
    end
  end
end