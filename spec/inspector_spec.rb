require 'spec_helper'

describe(Inspector) do
  let(:validator) { double() }
  before(:each) do
    Inspector.instance_variable_set(:@validator, validator)
  end

  describe "#valid" do
    it "calls @validator.valid" do
      validator.should_receive(:valid).once.with("validator name")
      Inspector.valid("validator name")
    end
  end

  describe "#validate" do
    it "calls @validator.validate" do
      validator.should_receive(:validate).once.with("value")
      Inspector.validate("value")
    end
  end
end