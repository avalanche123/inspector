module Inspector
  module Constraints
    False = Object.new

    def False.valid?(actual)
      !actual
    end

    def False.to_s
      "be_false"
    end

    def False.inspect
      "#<false>"
    end
  end
end