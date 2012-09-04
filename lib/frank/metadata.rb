module Frank
  class Metadata
    attr_reader :positive_constraints, :negative_constraints

    def initialize(positive_constraints = [], negative_constraints = [])
      @positive_constraints = positive_constraints
      @negative_constraints = negative_constraints
      @property_metadatas = []
      @attribute_metadatas = []
    end

    def run_validations(object, validation_context)
      @positive_constraints.each {|c| c.validate(object, validation_context)}
      @negative_constraints.each {|c| c.invalidate(object, validation_context)}

      object.each_with_index do |child, i|
        @children_metadata.run_validations(child, validation_context.child("[#{i}]"))
      end unless @children_metadata.nil?

      @property_metadatas.each do |property, property_metadata|
        property_metadata.run_validations(object[property], validation_context.child("[#{property}]"))
      end

      @attribute_metadatas.each do |attribute, attribute_metadata|
        attribute_metadata.run_validations(object.send(attribute), validation_context.child(".#{attribute}"))
      end
    end
  end
end