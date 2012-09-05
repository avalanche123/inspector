require 'spec_helper'

describe(Frank::Validator) do
  let(:walker) { double() }
  let(:metadata_map) { double() }
  let(:constraint_violation_lists) { double() }
  let(:validator) { Frank::Validator.new(metadata_map, walker, constraint_violation_lists) }

  describe "#valid" do
    let(:metadata_builder) { double() }

    it "configures Validatable" do
      metadata_map.should_receive(:add_metadata_for).with(nil).and_return(metadata_builder)
      expect(validator.valid(nil)).to be(metadata_builder)
    end
  end

  describe "#validate" do
    let(:metadata) { double() }
    let(:constraint_violation_list) { double() }

    it "raises if can't find Metadata" do
      constraint_violation_lists.stub(:new) { constraint_violation_list }
      metadata_map.should_receive(:get_metadata_for).with(NilClass).and_return(metadata)
      walker.should_receive(:walk_object).with(metadata, nil, constraint_violation_list)

      expect(validator.validate(nil)).to be(constraint_violation_list)
    end
  end
end