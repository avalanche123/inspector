require_relative '../spec_helper'

describe Frank::Validation do
  before(:each) do
    @subject = Class.new(BasicObject) do
      include Frank::Validation
    end
  end

  it "has no constraints" do
    @subject.constraints.must_be_empty
  end

  describe "#assert" do
    it "adds constraints" do
      # metadata = # ClassMetadata.for(@subject)
      # 
      # @subject.assert :attribute, :test_constraint
      # 
      # metadata.constraints.length.must_equal(1)
    end
  end
end