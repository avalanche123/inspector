module Frank
  module Validation
    module Constraints
      class Type
        include Validation::Constraint

        set :message, "This value should be of type %{type}"

        default_option :type
        required_options :type
      end
    end
  end
end