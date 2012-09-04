require 'spec_helper'

describe(Frank::MetadataBuilder) do
  let(:builder) { Frank::MetadataBuilder.new }

  it "includes constraints" do
    expect(Frank::MetadataBuilder.ancestors).to include(Frank::Constraints)
  end

  context "with metadata" do
    let(:metadata) { double() }

    before(:each) do
      builder.set_metadata(metadata)
    end

    describe "#should" do
      let(:constraint) { Frank::Constraints::False.new }

      it "adds positive constraint" do
        constraints = []
        metadata.stub(:positive_constraints) { constraints }

        builder.should(constraint)

        expect(constraints).to have(1).constraint
        expect(constraints.first).to be(constraint)
      end

      it "raises if invalid constraint given" do
        expect { builder.should(nil) }.to raise_error(
          ArgumentError,
          "constraint nil is invalid as it doesn't respond to validate and invalidate"
        )
      end
    end

    describe "#should_not" do
      let(:constraint) { Frank::Constraints::False.new }

      it "adds negative constraint" do
        constraints = []
        metadata.stub(:negative_constraints) { constraints }

        builder.should_not(constraint)

        expect(constraints).to have(1).constraint
        expect(constraints.first).to be(constraint)
      end

      it "raises if invalid constraint given" do
        expect { builder.should_not(nil) }.to raise_error(
          ArgumentError,
          "constraint nil is invalid as it doesn't respond to validate and invalidate"
        )
      end
    end
  end
end