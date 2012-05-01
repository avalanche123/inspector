module Frank
  module Validator
    module Constraints
      class Url
        include Validator::Constraint

        set :message, "This value is not a valid URL."
        set :protocols, ['http', 'https']
      end
    end
  end
end