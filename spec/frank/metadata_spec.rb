require 'spec_helper'

describe(Frank::Metadata) do
  let(:metadata) { Frank::Metadata.new }

  describe "#constraints" do
    it "are empty" do
      expect(metadata.constraints).to be_empty
    end
  end

  describe "#add_attribute_metadata" do
    it "sets attribute_metadata" do
      expect {
        metadata.add_attribute_metadata(:attribute)
      }.to change { metadata.attribute_metadatas.length }.from(0).to(1)
    end
  end
end