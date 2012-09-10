require 'spec_helper'

describe(Frank::Constraint::Violation::List) do
  let(:list) { Frank::Constraint::Violation::List.new }

  describe "#<<" do
    let(:violation) { double() }

    it "adds constraints" do
      violation.stub(:kind_of?) { true }

      expect { list << violation }.to change(list, :length).from(0).to(1)
    end

    it "raises when adding not a constraint" do
      expect {
        list << violation
      }.to raise_error("#{violation.inspect} is not a Frank::Constraint::Violation")
    end
  end

  describe "#at" do
    before(:each) do
      [
        ".attribute",
        ".attribute",
        "[property]",
        "[property].attribute",
        "[property].attribute",
        "[property].attribute",
        "[property].attribute"
      ].each do |property_path|
        list << Frank::Constraint::Violation.new(property_path, nil, nil)
      end
    end

    it "returns list of matching violations" do
      list.at(".attribute").length.should == 2
    end
  end
end