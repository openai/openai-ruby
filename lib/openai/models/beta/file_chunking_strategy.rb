# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      # @abstract
      #
      # The strategy used to chunk the file.
      class FileChunkingStrategy < OpenAI::Union
        discriminator :type

        variant :static, -> { OpenAI::Models::Beta::StaticFileChunkingStrategyObject }

        # This is returned when the chunking strategy is unknown. Typically, this is because the file was indexed before the `chunking_strategy` concept was introduced in the API.
        variant :other, -> { OpenAI::Models::Beta::OtherFileChunkingStrategyObject }

        # @!parse
        #   class << self
        #     # @return [Array(OpenAI::Models::Beta::StaticFileChunkingStrategyObject, OpenAI::Models::Beta::OtherFileChunkingStrategyObject)]
        #     def variants; end
        #   end
      end
    end
  end
end
