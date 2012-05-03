module Frank
  module Validation
    autoload :Constraint, 'frank/validation/constraint'
    autoload :Constraints, 'frank/validation/constraints'  
    autoload :Mapping, 'frank/validation/mapping'  

    def self.included(other)
      other.extend(self)
    end

    def assert(name, *constraints)
      Mapping.for(self).attribute_constraints[name] << 1
    end
  end
end