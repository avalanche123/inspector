require 'forwardable'

module Frank
  autoload :Validator,           'frank/validator'
  autoload :DSL,                 'frank/dsl'
  autoload :Constraints,         'frank/constraints'
  autoload :Constraint,         'frank/constraint'
  autoload :Metadata,            'frank/metadata'
  autoload :MetadataMap,         'frank/metadata_map'
  autoload :MetadataWalker,      'frank/metadata_walker'

  class << self
    extend Forwardable
    def_delegators :@validator, :validate, :valid
  end

  @validator = Validator.new(MetadataMap.new(DSL.new, Metadata), MetadataWalker.new, Constraint::Violation::List)
end