module Inspector
  module Constraints
    True = Object.new

    def True.valid?(actual)
      !!actual
    end

    def True.to_s
      "be_true"
    end

    def True.inspect
      "#<true>"
    end
  end
end