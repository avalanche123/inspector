module Frank
  class Metadata
    attr_reader :constraints, :property_metadatas, :attribute_metadatas, :children_metadata

    def initialize
      @constraints = []
      @property_metadatas = {}
      @attribute_metadatas = {}
    end

    def add_attribute_metadata(attribute)
      attribute_metadata = self.class.new
      @attribute_metadatas[attribute] = attribute_metadata
      attribute_metadata
    end
  end
end