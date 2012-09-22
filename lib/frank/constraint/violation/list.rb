module Frank
  module Constraint
    class Violation
      class List
        extend Forwardable
        def_delegators :@violations, :each, :map

        attr_reader :property_path, :value

        def initialize(property_path, value, violations = [], children = [])
          @property_path = property_path
          @value = value
          @violations = violations
          @children = children
        end

        def to_s
          if @property_path.empty?
            output = ""
            prefix = ""
          else
            output = "#{@property_path}:\n"
            prefix = "  "
          end

          unless @violations.empty?
            output += @violations.map {|v| "#{prefix}#{v.to_s}"}.join("\n")
          end

          unless @children.empty?
            @children.each do |list|
              output += list.to_s.split("\n").map {|l| "#{prefix}#{l.to_s}"}.join("\n")
              output += "\n"
            end
          end

          output
        end

        def inspect
          attributes = {
            :at            => @property_path.inspect,
            :value         => @value.inspect,
            :violations    => @violations.inspect,
            :children      => @children.inspect
          }.inject("") {|string, pair| "#{string} #{pair.first}=#{pair.last}"}

          "#<violations#{attributes}>"
        end

        def empty?
          @violations.empty? && @children.empty?
        end

        def length
          @violations.length + @children.map(&:length).reduce(:+)
        end

        def <<(violation)
          if violation.kind_of?(Frank::Constraint::Violation)
            @violations << violation
          elsif violation.kind_of?(Frank::Constraint::Violation::List)
            @children << violation
          else
            raise "#{violation.inspect} is not a Frank::Constraint::Violation"
          end
        end
        alias :push :<<

        def at(property_path)
          @children.select {|l| l.property_path == property_path}
        end
      end
    end
  end
end