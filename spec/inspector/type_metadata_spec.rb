require 'spec_helper'

describe(Inspector::TypeMetadata) do
  let(:metadata) { Inspector::TypeMetadata.new(type) }

  it_behaves_like Inspector::Metadata
end