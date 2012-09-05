require 'spec_helper'

describe(Frank::DSL) do
  let(:builder) { Frank::DSL.new }

  it "includes constraints" do
    expect(Frank::DSL.ancestors).to include(Frank::Constraints)
  end

  context "with metadata" do
    let(:metadata) { double() }

    before(:each) do
      builder.set_metadata(metadata)
    end

    describe "#should" do
      let(:constraint) { Frank::Constraints::False.new }

      it "adds constraint" do
        constraints = []
        metadata.stub(:constraints) { constraints }

        builder.should(constraint)

        expect(constraints).to have(1).constraint
        expect(constraints.first).to be(constraint)
      end

      it "raises if invalid constraint given" do
        expect { builder.should(nil) }.to raise_error(
          ArgumentError,
          "constraint nil is invalid as it doesn't respond to validate"
        )
      end
    end
  end
end