lib = File.dirname(__FILE__)

$:.unshift(lib) unless $:.include?(lib) || $:.include?(File.expand_path(lib))

require_relative 'frank/core_ext'

module Frank
  autoload :Validator, 'frank/validator'
  autoload :Validation, 'frank/validation'
end