module Frank
  class Metadata
    attr_reader :constraints, :property_metadatas, :attribute_metadatas, :children_metadata

    def initialize(constraints = [])
      @constraints = constraints
      @property_metadatas = []
      @attribute_metadatas = []
    end
  end
end