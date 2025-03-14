# frozen_string_literal: true

module OpenAI
  module Models
    # @abstract
    #
    # The strategy used to chunk the file.
    class FileChunkingStrategy < OpenAI::Union
      discriminator :type

      variant :static, -> { OpenAI::Models::StaticFileChunkingStrategyObject }

      # This is returned when the chunking strategy is unknown. Typically, this is because the file was indexed before the `chunking_strategy` concept was introduced in the API.
      variant :other, -> { OpenAI::Models::OtherFileChunkingStrategyObject }

      # @!parse
      #   class << self
      #     # @return [Array(OpenAI::Models::StaticFileChunkingStrategyObject, OpenAI::Models::OtherFileChunkingStrategyObject)]
      #     def variants; end
      #   end
    end
  end
end
