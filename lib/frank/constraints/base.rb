module Frank
  module Constraints
    class Base
      def validate(value, validation_context)
        validation_context.violate(self) unless valid?(value)
      end

      def invalidate(value, validation_context)
        validation_context.violate(self) if valid?(value)
      end
    end
  end
end