require 'spec_helper'

describe(Frank::TypeMetadata) do
  let(:type) { double() }
  let(:metadata) { Frank::TypeMetadata.new(type) }

  describe "#type" do
    it "is the original type" do
      expect(metadata.type).to be(type)
    end
  end

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

  describe "#attribute" do
    it "sets attribute_metadata" do
      expect {
        metadata.attribute(:attribute)
      }.to change { metadata.attribute_metadatas.length }.from(0).to(1)
    end
  end
end