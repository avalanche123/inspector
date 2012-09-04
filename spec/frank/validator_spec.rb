require 'spec_helper'

describe(Frank::Validator) do
  let(:validation_contexts) { double() }
  let(:metadata_map) { double() }
  let(:validator) { Frank::Validator.new(metadata_map, validation_contexts) }

  describe "#valid" do
    it "configures Validatable" do
      metadata_map.should_receive(:add_metadata_for).with(nil)
      validator.valid(nil)
    end
  end

  describe "#validate" do
    let(:metadata) { double() }
    let(:validation_context) { double() }

    it "raises if can't find Metadata" do
      validation_contexts.should_receive(:new).and_return(validation_context)
      metadata_map.should_receive(:get_metadata_for).with(NilClass).and_return(metadata)
      metadata.should_receive(:run_validations).with(nil, validation_context)

      expect(validator.validate(nil)).to be(validation_context)
    end
  end
end