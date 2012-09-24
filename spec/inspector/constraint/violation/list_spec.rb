require 'spec_helper'

describe(Inspector::Constraint::Violation::List) do
  let(:list) { Inspector::Constraint::Violation::List.new }

  describe "#<<" do
    let(:violation) { double() }

    it "adds constraints" do
      violation.stub(:kind_of?) { true }

      expect { list << violation }.to change(list, :length).from(0).to(1)
    end

    it "raises when adding not a constraint violation" do
      expect {
        list << violation
      }.to raise_error("#{violation.inspect} is not a Inspector::Constraint::Violation")
    end
  end

  describe "#[]=" do
    let(:property_path) { 'username' }
    let(:violation_list) { nil }

    it "raises when adding not a constraint violation list" do
      expect {
        list[property_path] = violation_list
      }.to raise_error("#{violation_list.inspect} is not a Inspector::Constraint::Violation::List")
    end
  end

  describe "#[]" do
    before(:each) do
      list["attribute"] = Inspector::Constraint::Violation::List.new([
        Inspector::Constraint::Violation.new(nil),
        Inspector::Constraint::Violation.new(nil)
      ])
    end

    it "returns list of matching violations" do
      list["attribute"].length.should == 2
    end
  end
end