module Frank
  class MetadataBuilder
    include Constraints

    def set_metadata(metadata)
      @metadata = metadata
    end

    def should(*constraints)
      constraints.each do |constraint|
        validate_constraint(constraint)

        @metadata.positive_constraints.push(constraint)
      end
    end

    def should_not(*constraints)
      constraints.each do |constraint|
        validate_constraint(constraint)

        @metadata.negative_constraints.push(constraint)
      end
    end

    def property(name, &block)
      new_builder(@metadata.add_property_metadata(name), &block)
    end

    def attribute(name, &block)
      new_builder(@metadata.add_attribute_metadata(name.to_sym), &block)
    end

    def children(&block)
      new_builder(@metadata.add_children_metadata, &block)
    end

    private

    def new_builder(metadata, &block)
      self.class.new(metadata, &block)
    end

    def validate_constraint(constraint)
      unless constraint.respond_to?(:validate) && constraint.respond_to?(:invalidate)
        raise ArgumentError, "constraint #{constraint.inspect} is invalid as it " +
                             "doesn't respond to validate and invalidate"
      end
    end
  end
end