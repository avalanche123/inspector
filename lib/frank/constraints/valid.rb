module Frank
  module Constraints
    class Valid
      def initialize(metadata_map, walker, type = nil)
        @metadata_map = metadata_map
        @walker = walker
        @type = type
      end

      def validate(value, violations, property_path)
        metadata = @metadata_map.get_metadata_for(@type || value.class)

        walk_object(metadata, value, violations, property_path)
      end
    end
  end
end