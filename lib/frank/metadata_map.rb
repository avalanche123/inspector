module Frank
  class MetadataMap
    def initialize(metadata_builder, metadatas, map = {})
      @metadata_builder = metadata_builder
      @metadatas = metadatas
      @map = map
    end

    def add_metadata_for(type, &block)
      metadata   = @metadatas.new
      @map[type] = metadata
      @metadata_builder.set_metadata(metadata)
      @metadata_builder.instance_eval(&block) if block_given?
      @metadata_builder
    end

    def get_metadata_for(type)
      @map.fetch(type)
    rescue KeyError
      raise ArgumentError, "validation information for #{type.inspect} doesn't exist, " +
                           "use Frank.valid(#{type.inspect}) to define it"
    end
  end
end