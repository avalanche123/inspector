module Frank
  module Validation
    autoload :DSL, 'frank/validation/dsl'

    def self.included(other)
      other.extend(DSL)
    end
  end
end