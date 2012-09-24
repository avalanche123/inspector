module Inspector
  module Metadata
    class Walker
      def initialize(violation_list_class, validator_map)
        @violation_list_class = violation_list_class
        @validator_map        = validator_map
      end

      def walk_object(metadata, object)
        violations = @violation_list_class.new

        metadata.constraints.each do |constraint|
          not_found = "validator #{constraint.validator} cannot be found"
          validator = @validator_map.fetch(constraint.validator) { raise not_found }

          validator.validate(object, constraint, violations)
        end

        # walk object attributes, properties and children if object constraints passed
        if violations.empty?
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
        end

        violations
      end
    end
  end
end