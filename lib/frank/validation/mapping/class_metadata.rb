module Frank
  module Mapping
    class ClassMetadata
      def add_constraint(constraint)
        constraints << constraint
      end

      def add_property_constraint(property, constraint)
        property_constraints[property] << constraint
      end
    end
  end
end