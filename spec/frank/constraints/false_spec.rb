require 'spec_helper'

describe Frank::Constraints::False do
  let(:constraint) { Frank::Constraints::False.new }

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