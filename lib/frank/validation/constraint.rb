module Frank
  module Validation
    module Constraint
      autoload :DSL, 'frank/validation/constraint/dsl'

      module ClassMethods
        def constraint_name
          @constraint_name ||= name.split('::').last.underscore.to_sym
        end
      end

      def self.included(other)
        other.extend(DSL)
        other.extend(ClassMethods)
      end

      def initialize(options = {})
        unless options.kind_of?(Hash)
          options = {default_option => options}
        end
        @options = default_options.merge(options)
        unless missing_options.empty?
          raise ArgumentError, "Missing the following required options: %s" % missing_options.join(', ')
        end
      end

      def [](option)
        @options[option]
      end

      private

      def default_option
        self.class.default_option_name
      end

      def default_options
        self.class.defaults
      end

      def required_options
        self.class.required_option_names
      end

      def missing_options
        required_options.reject { |n| @options.include?(n) }
      end
    end
  end
end