require 'spec_helper'

describe(Frank::PropertyMetadata) do
  let(:property) { 'name' }
  let(:metadata) { Frank::PropertyMetadata.new(type, property) }

  it_behaves_like Frank::Metadata
end