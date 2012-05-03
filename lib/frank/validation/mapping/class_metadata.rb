require 'set'

module Frank
  module Validation
    module Mapping
      class ClassMetadata
        def attribute_constraints
          @attribute_constraints ||= Hash.new(Set.new)
        end

        def constraints
          @constraints ||= Set.new
        end
      end
    end
  end
end