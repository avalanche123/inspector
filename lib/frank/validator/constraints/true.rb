module Frank
  module Validator
    module Constraints
      class True
        include Validator::Constraint

        set :message, "This value should be true."
      end
    end
  end
end