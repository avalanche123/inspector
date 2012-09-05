module Frank
  class MetadataWalker
    def walk_object(metadata, object, violations, property_path = '')
      metadata.constraints.each {|c| c.validate(object, violations, property_path)}

      object.each_with_index do |child, i|
        walk_object(metadata.children_metadata, child, violations, "[#{i}]")
      end unless metadata.children_metadata.nil?

      metadata.property_metadatas.each do |property, property_metadata|
        walk_object(property_metadata, object[property], violations, "[#{property}]")
      end

      metadata.attribute_metadatas.each do |attribute, attribute_metadata|
        walk_object(attribute_metadata, object.send(attribute), violations, ".#{attribute}")
      end
    end
  end
end