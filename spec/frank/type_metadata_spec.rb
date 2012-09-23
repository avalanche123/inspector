require 'spec_helper'

describe(Frank::TypeMetadata) do
  let(:metadata) { Frank::TypeMetadata.new(type) }

  it_behaves_like Frank::Metadata
end