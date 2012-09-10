require 'spec_helper'

describe(Frank::Validator) do
  let(:metadata_map) { double() }
  let(:type_metadata_class) { double() }
  let(:violation_list_class) { double() }
  let(:walker_class) { double() }
  let(:validator) {
    Frank::Validator.new(
      metadata_map,
      type_metadata_class,
      violation_list_class,
      walker_class
    )
  }

  describe "#valid" do
    let(:metadata) { double() }

    before(:each) do
      type_metadata_class.should_receive(:new).with(NilClass).and_return(metadata)
      metadata_map.should_receive(:[]=).with(NilClass, metadata).and_return(metadata)
    end

    it "registers new TypeMetadata in metadata map" do
      expect(validator.valid(NilClass)).to be(metadata)
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
    let(:violation_list) { double() }
    let(:walker) { double() }
    let(:object) { double() }

    before(:each) do
      violation_list_class.stub(:new) { violation_list }
      walker_class.should_receive(:new).with(violation_list).and_return(walker)
      walker.should_receive(:walk_object).with(metadata, object, "")
    end

    it "walks object using its class" do
      object.stub(:class) { NilClass }
      metadata_map.should_receive(:[]).with(NilClass).and_return(metadata)

      expect(validator.validate(object)).to be(violation_list)
    end

    it "walks object using metadata type specified" do
      metadata_map.should_receive(:[]).with("metadata type").and_return(metadata)

      expect(validator.validate(object, :as => "metadata type")).to be(violation_list)
    end
  end
end