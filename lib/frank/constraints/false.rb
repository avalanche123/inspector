module Frank
  module Constraints
    module False
      def self.valid?(actual)
        !actual
      end

      def self.to_s
        "false"
      end

      def self.inspect
        "#<Frank::Constraints::False>"
      end
    end
  end
end