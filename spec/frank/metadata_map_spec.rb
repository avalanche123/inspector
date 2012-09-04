require 'spec_helper'

describe(Frank::MetadataMap) do
  let(:metadata_builder) { double() }
  let(:metadatas) { double() }
  let(:metadata) { double() }
  let(:map) { {} }
  let(:metadata_map) { Frank::MetadataMap.new(metadata_builder, metadatas, map) }

  describe "#add_metadata_for" do
    before(:each) do
      metadatas.should_receive(:new).and_return(metadata)
      metadata_builder.should_receive(:set_metadata).with(metadata)
    end

    it "returns MetadataBuilder" do
      expect(metadata_map.add_metadata_for(nil)).to be(metadata_builder)
    end

    it "sets metadata instance on internal map" do
      map.should_receive(:[]=).with(nil, metadata)
      metadata_map.add_metadata_for(nil)
    end
  end

  describe "#get_metadata_for" do
    it "raises if no metadata registered" do
      expect { metadata_map.get_metadata_for(NilClass) }.to raise_error(
        ArgumentError, "validation information for NilClass doesn't exist, " +
                       "use Frank.valid(NilClass) to define it"
      )
    end

    it "fetches pre-registered metadata" do
      metadatas.should_receive(:new).and_return(metadata)
      metadata_builder.should_receive(:set_metadata).with(metadata)

      metadata_map.add_metadata_for(NilClass)

      expect(metadata_map.get_metadata_for(NilClass)).to be(metadata)
    end
  end
end