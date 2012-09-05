require 'spec_helper'

describe(Frank::Metadata) do
  let(:metadata) { Frank::Metadata.new }

  describe "#constraints" do
    it "are empty" do
      expect(metadata.constraints).to be_empty
    end
  end
end