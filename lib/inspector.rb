require 'forwardable'

module Inspector
  autoload :Validator,           'inspector/validator'
  autoload :DSL,                 'inspector/dsl'
  autoload :Constraints,         'inspector/constraints'
  autoload :Constraint,          'inspector/constraint'
  autoload :Metadata,            'inspector/metadata'
  autoload :TypeMetadata,        'inspector/type_metadata'
  autoload :AttributeMetadata,   'inspector/attribute_metadata'
  autoload :PropertyMetadata,    'inspector/property_metadata'

  class << self
    extend Forwardable
    def_delegators :@validator, :validate, :valid
  end

  @validator = Validator.new(
    Metadata::Map.new,
    Metadata::Walker.new(Constraint::Violation::List, Constraint::Violation),
    TypeMetadata
  )
end