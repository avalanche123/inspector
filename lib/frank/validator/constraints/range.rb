module Frank
  module Validator
    module Constraints
      class Range
        include Validator::Constraint

        set :min_message, "This value should be %{limit} or more."
        set :max_message, "This value should be %{limit} or less."

        default_option :range
        required_options :range
      end
    end
  end
end