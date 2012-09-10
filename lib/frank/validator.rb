module Frank
  class Validator
    def initialize(metadata_map, type_metadata_class, violation_list_class, walker_class)
      @metadata_map = metadata_map
      @type_metadata_class = type_metadata_class
      @violation_list_class = violation_list_class
      @walker_class = walker_class
    end

    def valid(type, &block)
      metadata = @type_metadata_class.new(type)
      if block_given?
        block.arity == 1 ? yield(metadata) : metadata.instance_eval(&block)
      end
      @metadata_map[type] = metadata
    end

    def validate(object, opts = {})
      type       = opts.fetch(:as) { object.class }
      metadata   = @metadata_map[type]
      violations = @violation_list_class.new
      walker     = @walker_class.new(violations)

      walker.walk_object(metadata, object, "")

      violations
    end
  end
end