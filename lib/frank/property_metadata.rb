module Frank
  class PropertyMetadata
    include Metadata

    attr_reader :attribute

    def initialize(type, property)
      @property = property
      super(type)
    end

    def property_value(object)
      object.__send__(:[], @property)
    rescue NoMethodError
      raise "metadata for #{@type.inspect} contains property metadata, however " +
            "#{object.inspect}[#{@property.inspect}] is not defined"
    end
  end
end