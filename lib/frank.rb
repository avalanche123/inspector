require 'forwardable'

module Frank
  autoload :Validator,           'frank/validator'
  autoload :MetadataBuilder,     'frank/metadata_builder'
  autoload :Constraints,         'frank/constraints'
  autoload :ValidationContext,   'frank/validation_context'
  autoload :Metadata,            'frank/metadata'
  autoload :MetadataMap,         'frank/metadata_map'
  autoload :ConstraintViolation, 'frank/constraint_violation'

  class << self
    extend Forwardable
    def_delegators :@validator, :validate, :valid
  end

  @validator = Validator.new(MetadataMap.new(MetadataBuilder.new, Metadata), ValidationContext)
end