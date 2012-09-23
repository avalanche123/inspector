require 'spec_helper'

describe(Inspector::AttributeMetadata) do
  let(:attribute) { 'name' }
  let(:metadata) { Inspector::AttributeMetadata.new(type, attribute) }

  it_behaves_like Inspector::Metadata
end