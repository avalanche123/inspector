module Inspector
  module Constraint
    class Violation
      class List
        attr_reader :violations, :children

        def initialize(violations = [], children = {})
          @violations = violations
          @children = children
        end

        def empty?
          @violations.empty? && @children.empty?
        end

        def length
          length  = @violations.length
          length += @children.values.map(&:length).reduce(:+) unless @children.empty?

          length
        end

        def <<(violation)
          unless violation.kind_of?(Inspector::Constraint::Violation)
            raise "#{violation.inspect} is not a Inspector::Constraint::Violation"
          end

          @violations << violation
        end
        alias :push :<<

        def []=(property_path, violations_list)
          unless violations_list.kind_of?(Inspector::Constraint::Violation::List)
            raise "#{violations_list.inspect} is not a Inspector::Constraint::Violation::List"
          end

          @children[property_path.to_s] = violations_list
        end

        def [](property_path)
          child_path, _, property_path = property_path.to_s.split(/(\.|\[|\])/, 2)

          not_found       = "cannot locate violations for #{property_path}"
          violations_list = @children.fetch(child_path) { raise not_found }

          if property_path
            violations_list[property_path]
          else
            violations_list
          end
        end

        def each(path = "", &block)
          @violations.each do |violation|
            yield(path, violation)
          end

          @children.each do |sub_path, list|
            prefix = "." unless path.empty? || sub_path.start_with?("[")

            list.each("#{path}#{prefix}#{sub_path}", &block)
          end
        end

        def to_s
          string = ""

          unless @violations.empty?
            string += @violations.map(&:to_s).join("\n")
            string += "\n"
          end

          @children.each do |path, list|
            unless list.empty?
              string += "#{path}:\n"
              string += list.to_s.split("\n").map {|line| "  #{line}"}.join("\n")
              string += "\n"
            end
          end

          string
        end

        def inspect
          "#<violations %{violations} children=%{children}>" % {
            :violations    => @violations.inspect,
            :children      => @children.inspect
          }
        end
      end
    end
  end
end