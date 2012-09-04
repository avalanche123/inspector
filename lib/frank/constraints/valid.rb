module Frank
  module Constraints
    class Valid
      def initialize(validator, as)
        @validator = validator
        @as = as
      end

      def validate(value, validation_context)
        validator.validate(value, validation_context)
      end
    end
  end
end