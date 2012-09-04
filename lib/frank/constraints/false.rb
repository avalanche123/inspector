module Frank
  module Constraints
    class False < Base
      def valid?(actual)
        !actual
      end
    end
  end
end