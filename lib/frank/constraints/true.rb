module Frank
  module Constraints
    class True < Base
      def valid?(actual)
        !!actual
      end

      def inspect
        "should be true"
      end
    end
  end
end