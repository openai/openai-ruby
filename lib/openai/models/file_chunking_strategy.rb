# frozen_string_literal: true

module OpenAI
  module Models
    # The strategy used to chunk the file.
    module FileChunkingStrategy
      extend OpenAI::Internal::Type::Union

      discriminator :type

      variant :static, -> { OpenAI::StaticFileChunkingStrategyObject }

      # This is returned when the chunking strategy is unknown. Typically, this is because the file was indexed before the `chunking_strategy` concept was introduced in the API.
      variant :other, -> { OpenAI::OtherFileChunkingStrategyObject }

      # @!method self.variants
      #   @return [Array(OpenAI::Models::StaticFileChunkingStrategyObject, OpenAI::Models::OtherFileChunkingStrategyObject)]
    end
  end
end
