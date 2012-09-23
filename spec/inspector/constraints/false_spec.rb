require 'spec_helper'

describe Inspector::Constraints::False do
  let(:constraint) { Inspector::Constraints::False }

  [
    [true, false],
    [false, true],
    [nil, true],
    ["string", false]
  ].each do |value, expected|
    describe "#valid?(#{value.inspect})" do
      it "is #{expected}" do
        constraint.valid?(value).should be(expected)
      end
    end
  end
end