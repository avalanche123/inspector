module Frank
  module Validation
    module Constraints
      class Url
        include Validation::Constraint

        set :message, "This value is not a valid URL."
        set :protocols, ['http', 'https']
      end
    end
  end
end