module Frank
  module Validator
    module Constraints
      class Regexp
        include Validator::Constraint

        set :message, "This value is not valid."
        set :match, true

        default_option :pattern
        required_options, :pattern
      end
    end
  end
end