require 'spec_helper'

describe(Inspector::Metadata::Map) do
  let(:metadata_map) { Inspector::Metadata::Map.new }

  describe "#[]=" do
    let(:metadata) { double() }

    it "raises if not a Metadata given" do
      expect {
        metadata_map[NilClass] = metadata
      }.to raise_error("#{metadata.inspect} is not a Inspector::Metadata")
    end

    it "returns Metadata" do
      metadata.stub(:kind_of?) { true }

      expect(metadata_map[NilClass] = metadata).to be(metadata)
    end
  end

  describe "#[]" do
    it "raises if no Metadata registered" do
      expect {
        metadata_map[NilClass]
      }.to raise_error("validation information for NilClass doesn't exist, use " +
                       "Inspector.valid(NilClass) to define it")
    end

    it "fetches pre-registered metadata" do
      metadata = double()
      metadata.stub(:kind_of?) { true }
      metadata_map[NilClass] = metadata

      expect(metadata_map[NilClass]).to be(metadata)
    end
  end
end