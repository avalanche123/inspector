require 'spec_helper'

describe(Frank::ValidationContext) do
  let(:errors) { double() }
  let(:constraint_violations) { double() }
  let(:validation_context) { Frank::ValidationContext.new(errors, constraint_violations) }
  let(:constraint) { double() }

  describe "#violate" do
    let(:constraint_violation) { double() }

    it "adds constraint violation" do
      constraint_violations.should_receive(:new).with(constraint).and_return(constraint_violation)
      errors.should_receive(:push).with(constraint_violation)

      validation_context.violate(constraint)
    end
  end

  describe "#valid?" do
    it "is true" do
      expect(validation_context.valid?).to be_true
    end
  end
end