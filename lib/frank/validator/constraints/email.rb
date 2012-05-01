module Frank
  module Validator
    module Constraints
      class Email
        include Validator::Constraint

        set :message, "This value is not a valid email address."
        set :check_mx, false
        set :check_host, false
      end
    end
  end
end