module Inspector
  module Constraints
    autoload :Base,        'inspector/constraints/base'
    autoload :False,       'inspector/constraints/false'
    autoload :True,        'inspector/constraints/true'
    autoload :Empty,       'inspector/constraints/empty'
    autoload :Predicate,   'inspector/constraints/predicate'
    autoload :Have,        'inspector/constraints/have'
    autoload :Email,       'inspector/constraints/email'
    autoload :Eq,          'inspector/constraints/eq'
    autoload :Valid,       'inspector/constraints/valid'

    def be_false
      False.new
    end

    def be_true
      True.new
    end

    def be_empty
      Empty.new
    end

    def have_at_least(n)
      Have::AtLeast.new(n)
    end

    def have_at_most(n)
      Have::AtMost.new(n)
    end

    def have(n)
      Have::Exactly.new(n)
    end
    alias :have_exactly :have

    def be_email
      Email.new
    end
    alias :be_an_email :be_email

    def eq(expected)
      Eq.new(expected)
    end

    def validate(options = {})
      Valid.new(options[:as])
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