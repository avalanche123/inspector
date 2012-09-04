module Frank
  module Constraints
    class True < Base
      def valid?(actual)
        !!actual
      end
    end
  end
end