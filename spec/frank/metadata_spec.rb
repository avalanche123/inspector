require 'spec_helper'

describe(Frank::Metadata) do
  let(:metadata) { Frank::Metadata.new }

  describe "#positive_constraints" do
    it "are empty" do
      expect(metadata.positive_constraints).to be_empty
    end
  end

  describe "#negative_constraints" do
    it "are empty" do
      expect(metadata.negative_constraints).to be_empty
    end
  end

  describe "#run_validations" do
    it "" do
    end
  end
end