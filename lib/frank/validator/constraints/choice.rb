module Frank
  module Validator
    module Constraints
      class Choice
        include Validator::Constraint

        set :multiple, false
        set :strict, false
        set :min, nil
        set :max, nil
        set :message, "The value you selected is not a valid choice."
        set :multiple_message, "One or more of the given values is invalid."
        set :min_message, "You must select at least %{min} choices."
        set :max_message, "You must select at most %{max} choices."

        default_option :choices
        allow :callback
      end
    end
  end
end