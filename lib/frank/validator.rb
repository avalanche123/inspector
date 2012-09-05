module Frank
  class Validator
    def initialize(metadata_map, walker, constraint_violation_lists)
      @metadata_map = metadata_map
      @walker = walker
      @constraint_violation_lists = constraint_violation_lists
    end

    def valid(type, &block)
      @metadata_map.add_metadata_for(type, &block)
    end

    def validate(object, opts = {})
      type = opts.fetch(:as) { object.class }
      violations = opts.fetch(:violations) { @constraint_violation_lists.new(object) }

      @walker.walk_object(@metadata_map.get_metadata_for(type), object, violations)

      violations
    end
  end
end