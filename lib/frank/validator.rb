module Frank
  class Validator
    def initialize(metadata_map, validation_contexts)
      @metadata_map = metadata_map
      @validation_contexts = validation_contexts
    end

    def valid(type, &block)
      @metadata_map.add_metadata_for(type, &block)
    end

    def validate(object, opts = {})
      type               = opts.fetch(:as) { object.class }
      validation_context = new_validation_context

      @metadata_map.get_metadata_for(type).run_validations(object, validation_context)

      validation_context
    end

    private

    def new_validation_context
      @validation_contexts.new
    end
  end
end