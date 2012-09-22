require 'forwardable'

module Frank
  autoload :Validator,           'frank/validator'
  autoload :DSL,                 'frank/dsl'
  autoload :Constraints,         'frank/constraints'
  autoload :Constraint,          'frank/constraint'
  autoload :Metadata,            'frank/metadata'
  autoload :TypeMetadata,        'frank/type_metadata'
  autoload :AttributeMetadata,   'frank/attribute_metadata'
  autoload :PropertyMetadata,    'frank/property_metadata'

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