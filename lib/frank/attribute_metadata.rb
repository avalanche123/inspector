module Frank
  class AttributeMetadata
    include Metadata

    attr_reader :attribute

    def initialize(type, attribute)
      @attribute = attribute
      super(type)
    end

    def attribute_value(object)
      object.__send__(@attribute)
    rescue NoMethodError
      raise "metadata for #{@type.inspect} contains attribute metadata, however " +
            "#{object.inspect}.#{@attribute.inspect} is not defined"
    end
  end
end