require 'spec_helper'

describe(Inspector::Validator) do
  let(:metadata_map) { double() }
  let(:walker) { double() }
  let(:type_metadata_class) { double() }
  let(:validator) {
    Inspector::Validator.new(
      metadata_map,
      walker,
      type_metadata_class
    )
  }

  describe "#valid" do
    let(:metadata) { double() }

    before(:each) do
      type_metadata_class.should_receive(:new).with(NilClass).and_return(metadata)
      metadata_map.should_receive(:[]=).with(NilClass, metadata).and_return(metadata)
    end

    it "registers new TypeMetadata in metadata map" do
      expect(validator.valid(NilClass)).to be(nil)
    end

    it "yields registered TypeMetadata" do
      validator.valid(NilClass) do |nil_metadata|
        expect(nil_metadata).to be(metadata)
      end
    end

    it "evaluates block in context of registered TypeMetadata" do
      context = nil
      validator.valid(NilClass) do
        context = self
      end

      expect(context).to be(metadata)
    end
  end

  describe "#validate" do
    let(:metadata) { double() }
    let(:violations) { double() }
    let(:object) { double() }

    before(:each) do
      walker.should_receive(:walk_object).with(metadata, object).and_return(violations)
    end

    it "walks object using its class" do
      object.stub(:class) { NilClass }
      metadata_map.should_receive(:[]).with(NilClass).and_return(metadata)

      expect(validator.validate(object)).to be(violations)
    end

    it "walks object using metadata type specified" do
      metadata_map.should_receive(:[]).with("metadata type").and_return(metadata)

      expect(validator.validate(object, :as => "metadata type")).to be(violations)
    end
  end
end