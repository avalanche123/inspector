module Inspector
  class AttributeMetadata
    include Metadata

    attr_reader :attribute_name

    def initialize(type, attribute_name)
      @attribute_name = attribute_name.to_sym
      super(type)
    end

    def attribute_value(object)
      object.__send__(@attribute_name)
    rescue NoMethodError
      raise "metadata for #{@type.inspect} contains attribute metadata, however " +
            "#{object.inspect}.#{@attribute_name.inspect} is not defined"
    end
  end
end