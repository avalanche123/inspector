require 'spec_helper'

describe(Frank) do
  let(:validator) { double() }
  before(:each) do
    Frank.instance_variable_set(:@validator, validator)
  end

  describe "#valid" do
    it "calls @validator.valid" do
      validator.should_receive(:valid).once.with("validator name")
      Frank.valid("validator name")
    end
  end

  describe "#validate" do
    it "calls @validator.validate" do
      validator.should_receive(:validate).once.with("value")
      Frank.validate("value")
    end
  end
end