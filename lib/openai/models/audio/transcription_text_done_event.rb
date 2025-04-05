# frozen_string_literal: true

module OpenAI
  module Models
    module Audio
      class TranscriptionTextDoneEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute text
        #   The text that was transcribed.
        #
        #   @return [String]
        required :text, String

        # @!attribute type
        #   The type of the event. Always `transcript.text.done`.
        #
        #   @return [Symbol, :"transcript.text.done"]
        required :type, const: :"transcript.text.done"

        # @!attribute [r] logprobs
        #   The log probabilities of the individual tokens in the transcription. Only
        #   included if you
        #   [create a transcription](https://platform.openai.com/docs/api-reference/audio/create-transcription)
        #   with the `include[]` parameter set to `logprobs`.
        #
        #   @return [Array<OpenAI::Models::Audio::TranscriptionTextDoneEvent::Logprob>, nil]
        optional :logprobs,
                 -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Models::Audio::TranscriptionTextDoneEvent::Logprob] }

        # @!parse
        #   # @return [Array<OpenAI::Models::Audio::TranscriptionTextDoneEvent::Logprob>]
        #   attr_writer :logprobs

        # @!parse
        #   # Emitted when the transcription is complete. Contains the complete transcription
        #   # text. Only emitted when you
        #   # [create a transcription](https://platform.openai.com/docs/api-reference/audio/create-transcription)
        #   # with the `Stream` parameter set to `true`.
        #   #
        #   # @param text [String]
        #   # @param logprobs [Array<OpenAI::Models::Audio::TranscriptionTextDoneEvent::Logprob>]
        #   # @param type [Symbol, :"transcript.text.done"]
        #   #
        #   def initialize(text:, logprobs: nil, type: :"transcript.text.done", **) = super

        # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void

        class Logprob < OpenAI::Internal::Type::BaseModel
          # @!attribute [r] token
          #   The token that was used to generate the log probability.
          #
          #   @return [String, nil]
          optional :token, String

          # @!parse
          #   # @return [String]
          #   attr_writer :token

          # @!attribute [r] bytes
          #   The bytes that were used to generate the log probability.
          #
          #   @return [Array<Object>, nil]
          optional :bytes, OpenAI::Internal::Type::ArrayOf[OpenAI::Internal::Type::Unknown]

          # @!parse
          #   # @return [Array<Object>]
          #   attr_writer :bytes

          # @!attribute [r] logprob
          #   The log probability of the token.
          #
          #   @return [Float, nil]
          optional :logprob, Float

          # @!parse
          #   # @return [Float]
          #   attr_writer :logprob

          # @!parse
          #   # @param token [String]
          #   # @param bytes [Array<Object>]
          #   # @param logprob [Float]
          #   #
          #   def initialize(token: nil, bytes: nil, logprob: nil, **) = super

          # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void
        end
      end
    end
  end
end
