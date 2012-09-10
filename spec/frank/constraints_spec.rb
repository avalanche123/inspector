require 'spec_helper'

describe(Frank::Constraints) do
  let(:constraint_helper) { Object.new }

  before(:each) do
    constraint_helper.extend Frank::Constraints
  end

  describe ".be_false" do
    it "creates False constraint" do
      expect(constraint_helper.be_false).to be(Frank::Constraints::False)
    end
  end
end