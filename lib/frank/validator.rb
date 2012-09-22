module Frank
  class Validator
    def initialize(metadata_map, walker, type_metadata_class)
      @metadata_map = metadata_map
      @walker = walker
      @type_metadata_class = type_metadata_class
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

      @walker.walk_object(metadata, object, "")
    end
  end
end