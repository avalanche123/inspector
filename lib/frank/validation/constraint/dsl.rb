require 'set'

module Frank
  module Validation
    module Constraint
      module DSL
        def self.extended(base)
          base.instance_variable_set(:@defaults, {})
          base.instance_variable_set(:@required_option_names, Set.new)
        end

        attr_reader :defaults
        attr_reader :default_option_name
        attr_reader :required_option_names

        def default_option(name)
          @default_option_name = name
        end

        def required_options(*names)
          @required_option_names.replace(names)
        end

        def set(option, value)
          @defaults[option] = value
        end
      end
    end
  end
end