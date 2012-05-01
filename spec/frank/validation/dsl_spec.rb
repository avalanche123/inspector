require_relative '../../spec_helper'

describe Frank::Validation::DSL do
  subject do
    Class.new(BasicObject) do
      include Frank::Validation::DSL
    end
  end
end