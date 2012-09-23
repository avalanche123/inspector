module Inspector
  module Metadata
    class Map
      def initialize
        @map = {}
      end

      def []=(type, metadata)
        unless metadata.kind_of?(Metadata)
          raise "#{metadata.inspect} is not a Inspector::Metadata"
        end

        @map[type] = metadata
      end

      def [](type)
        @map.fetch(type)
      rescue KeyError
        raise "validation information for #{type.inspect} doesn't exist, use " +
              "Inspector.valid(#{type.inspect}) to define it"
      end
    end
  end
end