module Frank
  module Constraint
    class Violation
      class List
        extend Forwardable
        def_delegators :@violations, :length, :empty?, :each, :map

        def initialize(violations = [])
          @violations = violations
        end

        def to_s
          @violations.map(&:to_s).join("\n")
        end

        def <<(violation)
          unless violation.kind_of?(Frank::Constraint::Violation)
            raise "#{violation.inspect} is not a Frank::Constraint::Violation"
          end

          @violations << violation
        end

        def at(property_path)
          self.class.new @violations.select {|v| v.property_path == property_path}
        end
      end
    end
  end
end