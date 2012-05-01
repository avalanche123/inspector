module Frank
  module Validator
    module Constraints
      class IPAddr
        include Validator::Constraint

        set :ipv4, true
        set :ipv6, true
        set :message, "This is not a valid IP address."
      end
    end
  end
end