module Inspector
  module Constraints
    class Valid
      include Constraint

      def initialize(*args)
        if args.length == 1
          @use_custom_type = true
          @type = args.first
        end
      end

      def validate_as(value)
        return @type if @use_custom_type
        value.class
      end

      def validator
        :validity
      end

      def to_s
        "validate"
      end

      def inspect
        "#<valid%{type}>" % { :type => " #{@type}".rstrip }
      end
    end
  end
end