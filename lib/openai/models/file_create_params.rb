# frozen_string_literal: true

module OpenAI
  module Models
    class FileCreateParams < OpenAI::BaseModel
      # @!parse
      #   extend OpenAI::RequestParameters::Converter
      include OpenAI::RequestParameters

      # @!attribute file
      #   The File object (not file name) to be uploaded.
      #
      #   @return [IO, StringIO]
      required :file, IO

      # @!attribute purpose
      #   The intended purpose of the uploaded file.
      #
      #     Use "assistants" for
      #     [Assistants](https://platform.openai.com/docs/api-reference/assistants) and
      #     [Message](https://platform.openai.com/docs/api-reference/messages) files,
      #     "vision" for Assistants image file inputs, "batch" for
      #     [Batch API](https://platform.openai.com/docs/guides/batch), and "fine-tune" for
      #     [Fine-tuning](https://platform.openai.com/docs/api-reference/fine-tuning).
      #
      #   @return [Symbol, OpenAI::Models::FilePurpose]
      required :purpose, enum: -> { OpenAI::Models::FilePurpose }

      # @!parse
      #   # @param file [IO, StringIO]
      #   # @param purpose [Symbol, OpenAI::Models::FilePurpose]
      #   # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
      #   #
      #   def initialize(file:, purpose:, request_options: {}, **) = super

      # def initialize: (Hash | OpenAI::BaseModel) -> void
    end
  end
end
