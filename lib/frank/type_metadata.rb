module Frank
  class TypeMetadata
    include Metadata

    def children(object, &block)
      object.each_with_index(&block)
    rescue NoMethodError
      raise "metadata for #{@type.inspect} contains children metadata, however " +
            "#{object.inspect}.each_with_index is not defined"
    end
  end
end