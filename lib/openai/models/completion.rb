# frozen_string_literal: true

module OpenAI
  module Models
    class Completion < OpenAI::BaseModel
      # @!attribute id
      #   A unique identifier for the completion.
      #
      #   @return [String]
      required :id, String

      # @!attribute choices
      #   The list of completion choices the model generated for the input prompt.
      #
      #   @return [Array<OpenAI::Models::CompletionChoice>]
      required :choices, -> { OpenAI::ArrayOf[OpenAI::Models::CompletionChoice] }

      # @!attribute created
      #   The Unix timestamp (in seconds) of when the completion was created.
      #
      #   @return [Integer]
      required :created, Integer

      # @!attribute model
      #   The model used for completion.
      #
      #   @return [String]
      required :model, String

      # @!attribute object
      #   The object type, which is always "text_completion"
      #
      #   @return [Symbol, :text_completion]
      required :object, const: :text_completion

      # @!attribute [r] system_fingerprint
      #   This fingerprint represents the backend configuration that the model runs with.
      #
      #     Can be used in conjunction with the `seed` request parameter to understand when
      #     backend changes have been made that might impact determinism.
      #
      #   @return [String, nil]
      optional :system_fingerprint, String

      # @!parse
      #   # @return [String]
      #   attr_writer :system_fingerprint

      # @!attribute [r] usage
      #   Usage statistics for the completion request.
      #
      #   @return [OpenAI::Models::CompletionUsage, nil]
      optional :usage, -> { OpenAI::Models::CompletionUsage }

      # @!parse
      #   # @return [OpenAI::Models::CompletionUsage]
      #   attr_writer :usage

      # @!parse
      #   # Represents a completion response from the API. Note: both the streamed and
      #   #   non-streamed response objects share the same shape (unlike the chat endpoint).
      #   #
      #   # @param id [String]
      #   # @param choices [Array<OpenAI::Models::CompletionChoice>]
      #   # @param created [Integer]
      #   # @param model [String]
      #   # @param system_fingerprint [String]
      #   # @param usage [OpenAI::Models::CompletionUsage]
      #   # @param object [Symbol, :text_completion]
      #   #
      #   def initialize(id:, choices:, created:, model:, system_fingerprint: nil, usage: nil, object: :text_completion, **) = super

      # def initialize: (Hash | OpenAI::BaseModel) -> void
    end
  end
end
