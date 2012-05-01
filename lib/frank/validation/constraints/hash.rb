module Frank
  module Validation
    module Constraints
      class Hash
        include Validation::Constraint

        set :extra_fields, false
        set :missing_fields, false
        set :extra_fields_message, "This field was not expected."
        set :missing_fields_message, "This field is missing."

        default_option :fields
        required_options :fields
      end
    end
  end
end