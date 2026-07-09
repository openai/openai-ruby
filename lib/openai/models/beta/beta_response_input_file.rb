# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class BetaResponseInputFile < OpenAI::Internal::Type::BaseModel
        # @!attribute type
        #   The type of the input item. Always `input_file`.
        #
        #   @return [Symbol, :input_file]
        required :type, const: :input_file

        # @!attribute detail
        #   The detail level of the file to be sent to the model. Use `auto` to let the
        #   system select the detail level; for GPT-5.6 and later models, `auto` uses
        #   high-quality rendering, which may increase input token usage. Use `low` for
        #   lower-cost rendering, or `high` to render the file at higher quality. Defaults
        #   to `auto`.
        #
        #   @return [Symbol, OpenAI::Models::Beta::BetaResponseInputFile::Detail, nil]
        optional :detail, enum: -> { OpenAI::Beta::BetaResponseInputFile::Detail }

        # @!attribute file_data
        #   The content of the file to be sent to the model.
        #
        #   @return [String, nil]
        optional :file_data, String

        # @!attribute file_id
        #   The ID of the file to be sent to the model.
        #
        #   @return [String, nil]
        optional :file_id, String, nil?: true

        # @!attribute file_url
        #   The URL of the file to be sent to the model.
        #
        #   @return [String, nil]
        optional :file_url, String

        # @!attribute filename
        #   The name of the file to be sent to the model.
        #
        #   @return [String, nil]
        optional :filename, String

        # @!attribute prompt_cache_breakpoint
        #   Marks the exact end of a reusable prompt prefix. The breakpoint inherits its TTL
        #   from the request's `prompt_cache_options.ttl`; the boundary is not rounded to a
        #   token block.
        #
        #   @return [OpenAI::Models::Beta::BetaResponseInputFile::PromptCacheBreakpoint, nil]
        optional :prompt_cache_breakpoint, -> { OpenAI::Beta::BetaResponseInputFile::PromptCacheBreakpoint }

        # @!method initialize(detail: nil, file_data: nil, file_id: nil, file_url: nil, filename: nil, prompt_cache_breakpoint: nil, type: :input_file)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Beta::BetaResponseInputFile} for more details.
        #
        #   A file input to the model.
        #
        #   @param detail [Symbol, OpenAI::Models::Beta::BetaResponseInputFile::Detail] The detail level of the file to be sent to the model. Use `auto` to let the syst
        #
        #   @param file_data [String] The content of the file to be sent to the model.
        #
        #   @param file_id [String, nil] The ID of the file to be sent to the model.
        #
        #   @param file_url [String] The URL of the file to be sent to the model.
        #
        #   @param filename [String] The name of the file to be sent to the model.
        #
        #   @param prompt_cache_breakpoint [OpenAI::Models::Beta::BetaResponseInputFile::PromptCacheBreakpoint] Marks the exact end of a reusable prompt prefix. The breakpoint inherits its TTL
        #
        #   @param type [Symbol, :input_file] The type of the input item. Always `input_file`.

        # The detail level of the file to be sent to the model. Use `auto` to let the
        # system select the detail level; for GPT-5.6 and later models, `auto` uses
        # high-quality rendering, which may increase input token usage. Use `low` for
        # lower-cost rendering, or `high` to render the file at higher quality. Defaults
        # to `auto`.
        #
        # @see OpenAI::Models::Beta::BetaResponseInputFile#detail
        module Detail
          extend OpenAI::Internal::Type::Enum

          AUTO = :auto
          LOW = :low
          HIGH = :high

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        # @see OpenAI::Models::Beta::BetaResponseInputFile#prompt_cache_breakpoint
        class PromptCacheBreakpoint < OpenAI::Internal::Type::BaseModel
          # @!attribute mode
          #   The breakpoint mode. Always `explicit`.
          #
          #   @return [Symbol, :explicit]
          required :mode, const: :explicit

          # @!method initialize(mode: :explicit)
          #   Marks the exact end of a reusable prompt prefix. The breakpoint inherits its TTL
          #   from the request's `prompt_cache_options.ttl`; the boundary is not rounded to a
          #   token block.
          #
          #   @param mode [Symbol, :explicit] The breakpoint mode. Always `explicit`.
        end
      end
    end

    BetaResponseInputFile = Beta::BetaResponseInputFile
  end
end
