require 'spec_helper'

describe(Inspector::PropertyMetadata) do
  let(:property) { 'name' }
  let(:metadata) { Inspector::PropertyMetadata.new(type, property) }

  it_behaves_like Inspector::Metadata
end