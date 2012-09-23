module Frank
  module Metadata
    class Walker
      def initialize(violation_list_class, violation_class)
        @violation_list_class = violation_list_class
        @violation_class      = violation_class
      end

      def walk_object(metadata, object)
        violations    = @violation_list_class.new

        # determine all object constraints that are not valid
        failed_constraints = metadata.constraints.select do |positive, constraint|
          positive ^ constraint.valid?(object)
        end

        # walk object attributes, properties and children if object constraints passed
        if failed_constraints.empty?
          metadata.attribute_metadatas.each do |metadata|
            path  = metadata.attribute_name
            value = metadata.attribute_value(object)

            violations[path] = walk_object(metadata, value)
          end

          metadata.property_metadatas.each do |metadata|
            path  = "[#{metadata.property_name}]"
            value = metadata.property_value(object)

            violations[path] = walk_object(metadata, value)
          end

          metadata.children_metadata.children(object) do |child, index|
            path = "[#{index}]"

            violations[path] = walk_object(metadata.children_metadata, child, path)
          end unless metadata.children_metadata.nil?
        else
          failed_constraints.each do |positive, constraint|
            violations << @violation_class.new(constraint, positive)
          end
        end

        violations
      end
    end
  end
end