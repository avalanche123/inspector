module Frank
  module Constraint
    class Violation
      class List
        def initialize(violations = [], children = {})
          @violations = violations
          @children = children
        end

        def to_s
          string = ""

          unless @violations.empty?
            string += @violations.map(&:to_s).join("\n")
            string += "\n"
          end

          @children.each do |path, list|
            string += "#{path}:\n"
            string += list.to_s.split("\n").map {|line| "  #{line}"}.join("\n")
            string += "\n"
          end

          string
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
          @violations.length + @children.values.map(&:length).reduce(:+)
        end

        def <<(violation)
          unless violation.kind_of?(Frank::Constraint::Violation)
            raise "#{violation.inspect} is not a Frank::Constraint::Violation"
          end

          @violations << violation
        end
        alias :push :<<

        def []=(property_path, violations_list)
          unless violations_list.kind_of?(Frank::Constraint::Violation::List)
            raise "#{violations_list.inspect} is not a Frank::Constraint::Violation::List"
          end

          @children[property_path] = violations_list
        end

        def [](property_path)
          child_path, _, property_path = property_path.split(/(\.|\[|\])/, 2)

          not_found       = "cannot locate violations for #{property_path}"
          violations_list = @children.fetch(child_path) { raise not_found }

          if property_path
            violations_list[property_path]
          else
            violations_list
          end
        end

        def each(*args, &block)
          @violations.each(*args, &block)
          @children.values.each { |list| list.each(*args, &block) }
        end
      end
    end
  end
end