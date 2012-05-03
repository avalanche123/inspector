module Frank
  module Validation
    module Mapping
      autoload :ClassMetadata, 'frank/validation/mapping/class_metadata'

      @map = {}

      def self.for(klass)
        @map[klass] ||= ClassMetadata.new
      end
    end
  end
end