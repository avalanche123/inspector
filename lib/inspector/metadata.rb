module Inspector
  module Metadata
    autoload :Map,    'inspector/metadata/map'
    autoload :Walker, 'inspector/metadata/walker'

    include Constraints

    attr_reader :type, \
                :constraints, \
                :children_metadata

    def initialize(type)
      @type = type
      @constraints = []
      @property_metadatas = {}
      @attribute_metadatas = {}
    end

    def attribute(name, &block)
      @attribute_metadatas[name] ||= AttributeMetadata.new(@type, name)
      if block_given?
        block.arity == 1 ? yield(@attribute_metadatas[name]) : @attribute_metadatas[name].instance_eval(&block)
      end
      @attribute_metadatas[name]
    end

    def property(name, &block)
      @property_metadatas[name] ||= PropertyMetadata.new(@type, name)
      if block_given?
        block.arity == 1 ? yield(@property_metadatas[name]) : @property_metadatas[name].instance_eval(&block)
      end
      @property_metadatas[name]
    end

    def each_item(&block)
      @children_metadata ||= TypeMetadata.new(@type)
      if block_given?
        block.arity == 1 ? yield(@children_metadata) : @children_metadata.instance_eval(&block)
      end
      @children_metadata
    end

    def should(constraint = nil)
      return PositiveComparator.new(self) if constraint.nil?

      @constraints << [true, constraint]

      self
    end

    def should_not(constraint = nil)
      return NegativeComparator.new(self) if constraint.nil?

      @constraints << [false, constraint]

      self
    end

    def attribute_metadatas
      @attribute_metadatas.values
    end

    def property_metadatas
      @property_metadatas.values
    end

    def children(object, &block)
      object.each_with_index(&block)
    rescue NoMethodError
      raise "metadata for #{@type.inspect} contains children metadata, however " +
            "#{object.inspect}.each_with_index is not defined"
    end
  end
end