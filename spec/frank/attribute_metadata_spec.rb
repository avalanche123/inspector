require 'spec_helper'

describe(Frank::AttributeMetadata) do
  let(:attribute) { 'name' }
  let(:metadata) { Frank::AttributeMetadata.new(type, attribute) }

  it_behaves_like Frank::Metadata
end