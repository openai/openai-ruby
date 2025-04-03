# frozen_string_literal: true

module OpenAI
  module Models
    # The strategy used to chunk the file.
    module FileChunkingStrategy
      extend OpenAI::Internal::Type::Union

      discriminator :type

      variant :static, -> { OpenAI::Models::StaticFileChunkingStrategyObject }

      # This is returned when the chunking strategy is unknown. Typically, this is because the file was indexed before the `chunking_strategy` concept was introduced in the API.
      variant :other, -> { OpenAI::Models::OtherFileChunkingStrategyObject }

      # @!parse
      #   # @return [Array(OpenAI::Models::StaticFileChunkingStrategyObject, OpenAI::Models::OtherFileChunkingStrategyObject)]
      #   def self.variants; end
    end
  end
end
