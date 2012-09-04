module Frank
  module Constraints
    autoload :Base,  'frank/constraints/base'
    autoload :False, 'frank/constraints/false'
    autoload :True,  'frank/constraints/true'

    def be_false
      Frank::Constraints::False.new
    end

    def be_true
      Frank::Constraints::True.new
    end
  end
end