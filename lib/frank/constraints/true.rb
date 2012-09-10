module Frank
  module Constraints
    module True
      def self.valid?(actual)
        !!actual
      end

      def self.to_s
        "true"
      end

      def self.inspect
        "#<Frank::Constraints::True>"
      end
    end
  end
end