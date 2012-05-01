require_relative '../../spec_helper'

class SimpleConstraint
  include Frank::Validator::Constraint
end

class WithOptions
  include Frank::Validator::Constraint

  set :option, 'option value'
  set :another_option, 'another value'
end

class WithDefaultOption
  include Frank::Validator::Constraint

  default_option :default_option
end

class WithRequiredOptions
  include Frank::Validator::Constraint

  required_options :required_option1, :required_option2
end

describe Frank::Validator::Constraint do
  describe 'simple constraint' do
    subject { SimpleConstraint }

    it "has a name" do
      subject.constraint_name.must_equal(:simple_constraint)
    end
  end

  describe 'with options' do
    describe 'no options specified' do
      subject { WithOptions.new }

      it 'inherits default option values' do
        subject[:option].must_equal('option value')
        subject[:another_option].must_equal('another value')
      end
    end

    describe 'options hash given' do
      subject { WithOptions.new(:option => 'overriden') }

      it 'overrides options' do
        subject[:option].must_equal('overriden')
        subject[:another_option].must_equal('another value')
      end
    end
  end

  describe 'with default option' do
    subject { WithDefaultOption.new('overriden value') }

    it 'accepts default option value in constructor' do
      subject[:default_option].must_equal('overriden value')
    end
  end

  describe 'with required options' do
    it 'raises if not all required options are set' do
      proc { WithRequiredOptions.new }.must_raise(ArgumentError)
    end
  end
end