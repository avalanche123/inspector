require 'spec_helper'

shared_examples_for Inspector::Metadata do
  let(:type) { double() }

  describe "#type" do
    it "is the original type" do
      expect(metadata.type).to be(type)
    end
  end

  describe "#constraints" do
    it "are empty" do
      expect(metadata.constraints).to be_empty
    end
  end

  describe "#attribute" do
    it "adds attribute metadata" do
      expect {
        metadata.attribute(:attribute)
      }.to change { metadata.attribute_metadatas.length }.from(0).to(1)
    end
  end

  describe "#property" do
    it "adds property metadata" do
      expect {
        metadata.property(:property)
      }.to change { metadata.property_metadatas.length }.from(0).to(1)
    end
  end
end