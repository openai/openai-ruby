# frozen_string_literal: true

module OpenAI
  module Models
    # @see OpenAI::Resources::Completions#create
    #
    # @see OpenAI::Resources::Completions#create_streaming
    class Completion < OpenAI::Internal::Type::BaseModel
      # @!attribute id
      #   A unique identifier for the completion.
      #
      #   @return [String]
      required :id, String

      # @!attribute choices
      #   The list of completion choices the model generated for the input prompt.
      #
      #   @return [Array<OpenAI::CompletionChoice>]
      required :choices, -> { OpenAI::Internal::Type::ArrayOf[OpenAI::CompletionChoice] }

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

      # @!attribute system_fingerprint
      #   This fingerprint represents the backend configuration that the model runs with.
      #
      #   Can be used in conjunction with the `seed` request parameter to understand when
      #   backend changes have been made that might impact determinism.
      #
      #   @return [String, nil]
      optional :system_fingerprint, String

      # @!attribute usage
      #   Usage statistics for the completion request.
      #
      #   @return [OpenAI::CompletionUsage, nil]
      optional :usage, -> { OpenAI::CompletionUsage }

      # @!method initialize(id:, choices:, created:, model:, system_fingerprint: nil, usage: nil, object: :text_completion)
      #   Some parameter documentations has been truncated, see {OpenAI::Completion} for
      #   more details.
      #
      #   Represents a completion response from the API. Note: both the streamed and
      #   non-streamed response objects share the same shape (unlike the chat endpoint).
      #
      #   @param id [String] A unique identifier for the completion.
      #
      #   @param choices [Array<OpenAI::CompletionChoice>] The list of completion choices the model generated for the input prompt.
      #
      #   @param created [Integer] The Unix timestamp (in seconds) of when the completion was created.
      #
      #   @param model [String] The model used for completion.
      #
      #   @param system_fingerprint [String] This fingerprint represents the backend configuration that the model runs with.
      #
      #   @param usage [OpenAI::CompletionUsage] Usage statistics for the completion request.
      #
      #   @param object [Symbol, :text_completion] The object type, which is always "text_completion"
    end
  end
end
