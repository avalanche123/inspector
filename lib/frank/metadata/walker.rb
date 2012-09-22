module Frank
  module Metadata
    class Walker
      def initialize(violation_list_class, violation_class)
        @violation_list_class = violation_list_class
        @violation_class      = violation_class
      end

      def walk_object(metadata, object, property_path)
        violations = @violation_list_class.new(property_path, object)

        # determine all object constraints that are not valid
        failed_constraints = metadata.constraints.select do |positive, constraint|
          positive ^ constraint.valid?(object)
        end

        # walk object attributes, properties and children if object constraints passed
        if failed_constraints.empty?
          metadata.attribute_metadatas.each do |metadata|
            attribute_violations = walk_attribute(metadata, object, property_path)
            violations << attribute_violations unless attribute_violations.empty?
          end

          metadata.property_metadatas.each do |metadata|
            property_violations = walk_property(metadata, object, property_path)
            violations << property_violations unless property_violations.empty?
          end

          metadata.children_metadata.children(object) do |child, index|
            child_violations = walk_object(metadata, child, index, property_path)
            violations << child_violations unless child_violations.empty?
          end unless metadata.children_metadata.nil?
        else
          failed_constraints.each do |positive, constraint|
            violations << @violation_class.new(positive, constraint)
          end
        end

        violations
      end

      private

      def walk_attribute(metadata, object, property_path)
        attribute_path  = [property_path, metadata.attribute].reject(&:empty?).join(".")
        attribute_value = metadata.attribute_value(object)

        walk_object(metadata, attribute_value, attribute_path)
      end

      def walk_property(metadata, object, property_path)
        property_path  = "#{property_path}[#{metadata.property}]"
        property_value = metadata.property_value(object)

        walk_object(metadata, property_value, property_path)
      end

      def walk_child(metadata, object, index, property_path)
        child_path = "#{property_path}[#{index}]"

        walk_object(metadata, object, child_path)
      end
    end
  end
end