module Frank
  module Metadata
    class Walker
      def initialize(violations)
        @violations = violations
      end

      def walk_object(metadata, object, property_path)
        metadata.positive_constraints.each do |constraint|
          unless constraint.valid?(object)
            @violations << Constraint::Violation.new(property_path, object, constraint)
          end
        end

        metadata.negative_constraints.each do |constraint|
          if constraint.valid?(object)
            @violations << Constraint::Violation.new(property_path, object, constraint)
          end
        end

        metadata.attribute_metadatas.each do |metadata|
          walk_attribute(metadata, object, property_path)
        end

        metadata.property_metadatas.each do |metadata|
          walk_property(metadata, object, property_path)
        end

        unless metadata.children_metadata.nil?
          walk_children(metadata.children_metadata, object, property_path)
        end
      end

      def walk_attribute(metadata, object, property_path)
        walk_object(metadata, metadata.attribute_value(object), "#{property_path}.#{metadata.attribute}")
      end

      def walk_property(metadata, object, property_path)
        walk_object(metadata, metadata.property_value(object), "#{property_path}[#{metadata.property}]")
      end

      def walk_children(metadata, object, context)
        metadata.children(object) do |child, index|
          walk_object(metadata, child, "#{property_path}[#{index}]")
        end
      end

      private

      def handle_constraints(handler, constraints)
        constraints.each do |constraint|
          handler.handle(object, constraint)
        end
      end

      def walk_children_metadata(metadata, object, context)
        object.each_with_index do |child, i|
          walk_object_metadata(metadata.children_metadata, child, context.for_path("[#{i}]"))
        end unless metadata.children_metadata.nil?
      end

      def walk_property_metadata(metadata, object, context)
        walk_object_metadata(metadata, object[metadata.property], context)
      end

      def walk_attribute_metadatas(metadata, object, context)
        metadata.attribute_metadatas.each do |metadata|
          walk_object(metadata, object.__send__(metadata.attribute), context.for_path(".#{metadata.attribute}"))
        end
      end
    end
  end
end