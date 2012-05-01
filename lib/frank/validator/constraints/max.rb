module Frank
  module Validator
    module Constraints
      class Max
        include Validator::Constraint

        set :message, "This value should be %{limit} or less."
        set :invalid_message, "This value should be a valid number."

        default_option :limit
        required_options :limit
      end
    end
  end
end