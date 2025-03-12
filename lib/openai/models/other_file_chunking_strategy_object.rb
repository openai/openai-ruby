# frozen_string_literal: true

module OpenAI
  module Models
    class OtherFileChunkingStrategyObject < OpenAI::BaseModel
      # @!attribute type
      #   Always `other`.
      #
      #   @return [Symbol, :other]
      required :type, const: :other

      # @!parse
      #   # This is returned when the chunking strategy is unknown. Typically, this is
      #   #   because the file was indexed before the `chunking_strategy` concept was
      #   #   introduced in the API.
      #   #
      #   # @param type [Symbol, :other]
      #   #
      #   def initialize(type: :other, **) = super

      # def initialize: (Hash | OpenAI::BaseModel) -> void
    end
  end
end
