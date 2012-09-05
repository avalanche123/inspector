module Frank
  module Constraint
    class Violation
      class List
        extend Forwardable
        def_delegators :@violations, :push, :<<


        def initialize(value)
          @value = value
          @violations = []
        end

        def inspect
          "#{@value.inspect}:\n" + @violations.map {|v| "  #{v.inspect}"}.join("\n")
        end
      end
    end
  end
end