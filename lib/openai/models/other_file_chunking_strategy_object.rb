# frozen_string_literal: true

module OpenAI
  module Models
    class OtherFileChunkingStrategyObject < OpenAI::Internal::Type::BaseModel
      # @!attribute type
      #   Always `other`.
      #
      #   @return [Symbol, :other]
      required :type, const: :other

      # @!method initialize(type: :other)
      #   This is returned when the chunking strategy is unknown. Typically, this is
      #   because the file was indexed before the `chunking_strategy` concept was
      #   introduced in the API.
      #
      #   @param type [Symbol, :other]
    end
  end
end
