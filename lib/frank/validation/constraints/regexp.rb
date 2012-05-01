module Frank
  module Validation
    module Constraints
      class Regexp
        include Validation::Constraint

        set :message, "This value is not valid."
        set :match, true

        default_option :pattern
        required_options, :pattern
      end
    end
  end
end