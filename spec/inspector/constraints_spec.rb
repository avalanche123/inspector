require 'spec_helper'

describe(Inspector::Constraints) do
  let(:constraint_helper) { Object.new }

  before(:each) do
    constraint_helper.extend Inspector::Constraints
  end

  describe ".be_false" do
    it "creates False constraint" do
      expect(constraint_helper.be_false).to be(Inspector::Constraints::False)
    end
  end
end