module Frank
  module Constraints
    autoload :Base,        'frank/constraints/base'
    autoload :False,       'frank/constraints/false'
    autoload :True,        'frank/constraints/true'
    autoload :Predicate,   'frank/constraints/predicate'
    autoload :Have,        'frank/constraints/have'
    autoload :HaveAtLeast, 'frank/constraints/have_at_least'
    autoload :HaveAtMost,  'frank/constraints/have_at_most'
    autoload :Email,       'frank/constraints/email'
    autoload :Eq,          'frank/constraints/eq'

    def be_false
      Frank::Constraints::False
    end

    def be_true
      Frank::Constraints::True
    end

    def have_at_least(n)
      Frank::Constraints::Have::AtLeast.new(n)
    end

    def have_at_most(n)
      Frank::Constraints::Have::AtMost.new(n)
    end

    def have(n)
      Frank::Constraints::Have::Exactly.new(n)
    end
    alias :have_exactly :have

    def be_email
      Frank::Constraints::Email
    end
    alias :be_an_email :be_email

    def ==(expected)
      Frank::Constraints::Eq.new(expected)
    end

    # be_empty => value.empty?
    # be_nil   => value.nil?
    def method_missing(method, *args, &block)
      prefix, *predicate = method.to_s.split("_")
      predicate.shift if ["a", "an"].include?(predicate.first)
      return Frank::Constraints::Predicate.new(predicate.join("_"), *args, &block) if prefix == "be"
      # return Frank::Constraints::Has.new(method, *args, &block) if method.to_s =~ /^have_/
      super
    end
  end
end