require_relative '../../spec_helper'

describe Frank::Validation::DSL do
  before(:each) do
    @subject = Class.new(BasicObject) do
      include Frank::Validation::DSL
    end
  end
end