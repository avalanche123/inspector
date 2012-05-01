module Frank
  module Validation
    autoload :Constraint, 'frank/validation/constraint'
    autoload :Constraints, 'frank/validation/constraints'  

    def self.included(other)
      other.extend(self)
    end

    def self.extended(other)
      other.instance_variable_set(:@constraints, [])
    end

    attr_reader :constraints

    def assert(name, *constraints)
      @constraints << 1
    end
  end
end