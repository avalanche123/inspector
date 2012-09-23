module Frank
  class PropertyMetadata
    include Metadata

    attr_reader :property_name

    def initialize(type, property_name)
      @property_name = property_name
      super(type)
    end

    def property_value(object)
      object.__send__(:[], @property_name)
    rescue NoMethodError
      raise "metadata for #{@type.inspect} contains property metadata, however " +
            "#{object.inspect}[#{@property_name.inspect}] is not defined"
    end
  end
end