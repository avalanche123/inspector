module Frank
  class DSL
    include Constraints

    def set_metadata(metadata)
      @metadata = metadata
    end

    def should(constraint = nil)
      return self if constraint.nil?

      validate_constraint(constraint)

      @metadata.constraints.push(constraint)
    end

    def should_not(constraint = nil)
      return self if constraint.nil?
    end

    def property(name, &block)
      new_builder(@metadata.add_property_metadata(name), &block)
    end

    def attribute(name, &block)
      metadata  = @metadata
      @metadata = @metadata.add_attribute_metadata(name.to_sym)

      instance_eval(&block) if block_given?

      @metadata = metadata
    end

    def children(&block)
      new_builder(@metadata.add_children_metadata, &block)
    end

    private

    def new_builder(metadata, &block)
      self.class.new(metadata, &block)
    end

    def validate_constraint(constraint)
      unless constraint.respond_to?(:validate)
        raise ArgumentError, "constraint #{constraint.inspect} is invalid as it " +
                             "doesn't respond to validate"
      end
    end
  end
end