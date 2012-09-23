module Inspector
  module Constraints
    autoload :Base,        'inspector/constraints/base'
    autoload :False,       'inspector/constraints/false'
    autoload :True,        'inspector/constraints/true'
    autoload :Predicate,   'inspector/constraints/predicate'
    autoload :Have,        'inspector/constraints/have'
    autoload :Email,       'inspector/constraints/email'
    autoload :Eq,          'inspector/constraints/eq'

    def be_false
      Inspector::Constraints::False
    end

    def be_true
      Inspector::Constraints::True
    end

    def have_at_least(n)
      Inspector::Constraints::Have::AtLeast.new(n)
    end

    def have_at_most(n)
      Inspector::Constraints::Have::AtMost.new(n)
    end

    def have(n)
      Inspector::Constraints::Have::Exactly.new(n)
    end
    alias :have_exactly :have

    def be_email
      Inspector::Constraints::Email
    end
    alias :be_an_email :be_email

    def eq(expected)
      Inspector::Constraints::Eq.new(expected)
    end

    # be_empty => value.empty?
    # be_nil   => value.nil?
    def method_missing(method, *args, &block)
      prefix, *predicate = method.to_s.split("_")
      predicate.shift if ["a", "an"].include?(predicate.first)
      return Inspector::Constraints::Predicate.new(predicate.join("_"), *args, &block) if prefix == "be"
      # return Inspector::Constraints::Has.new(method, *args, &block) if method.to_s =~ /^have_/
      super
    end
  end
end