module Frank
  module Validation
    module Constraints
      class Email
        include Validation::Constraint

        set :message, "This value is not a valid email address."
        set :check_mx, false
        set :check_host, false
      end
    end
  end
end