module Inspector
  module Constraint
    autoload :Violation,  'inspector/constraint/violation'
    autoload :Validators, 'inspector/constraint/validators'

    def negate!
      @negative = true
    end

    def positive?
      !@negative
    end

    def validator
      :simple
    end
  end
end