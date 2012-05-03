require_relative '../spec_helper'

describe Frank::Validation do
  before(:each) do
    @subject = Class.new(BasicObject) do
      include Frank::Validation
    end
    @mapping = Frank::Validation::Mapping.for(@subject)
  end

  it "has no constraints" do
    @mapping.constraints.must_be_empty
  end

  describe "#assert" do
    it "adds constraints" do
      @subject.assert :attribute, :test_constraint

      @mapping.attribute_constraints[:attribute].length.must_equal(1)
    end
  end
end