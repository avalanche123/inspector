module Inspector
  module Constraints
    module Have
      include Constraint

      class AtLeast
        include Have

        def to_s
          "have_at_least"
        end

        def compare(actual)
          actual >= @expected
        end
      end

      class AtMost
        include Have

        def to_s
          "have_at_most"
        end

        def compare(actual)
          actual <= @expected
        end
      end

      class Exactly
        include Have

        def to_s
          "have_exactly"
        end

        def compare(actual)
          actual == @expected
        end
      end

      def initialize(expected)
        @expected        = expected.to_i
      end

      def valid?(collection_or_owner)
        collection = determine_collection(collection_or_owner)
        return false if collection.nil?
        query_method = determine_query_method(collection)
        compare(collection.__send__(query_method))
      end

      def inspect
        "#<%{constraint} %{expected}%{collection}>" % {
          :constraint => to_s.split('_').join(' '),
          :expected   => @expected.inspect,
          :collection => " #{@collection_name}".rstrip
        }
      end

      def method_missing(method, *args, &block)
        @collection_name = method
        @args = args
        @block = block
        self
      end

      private

      def determine_collection(collection_or_owner)
        collection_or_owner.__send__(@collection_name, *@args, &@block) if collection_or_owner.respond_to?(@collection_name)
        collection_or_owner if determine_query_method(collection_or_owner)
        # elsif (@plural_collection_name && collection_or_owner.respond_to?(@plural_collection_name))
        #   collection_or_owner.__send__(@plural_collection_name, *@args, &@block)
        # else
        #   collection_or_owner.__send__(@collection_name, *@args, &@block)
        # end
      end

      def determine_query_method(collection)
        [:size, :length, :count].detect {|m| collection.respond_to?(m)}
      end
    end
  end
end