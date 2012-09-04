module Frank
  class ValidationContext
    attr_reader :errors

    def initialize(errors = [], constraint_violations = ConstraintViolation)
      @errors = errors
      @constraint_violations = constraint_violations
    end

    def violate(constraint)
      @errors.push(@constraint_violations.new(constraint))
    end

    def valid?
      true
    end
    
    def inspect
      "#{value.inspect}\n" + @errors.map {|e| "  #{e.inspect}\n"}
    end
  end
end