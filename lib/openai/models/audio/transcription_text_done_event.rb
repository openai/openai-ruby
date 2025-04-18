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

        # @!attribute logprobs
        #   The log probabilities of the individual tokens in the transcription. Only
        #   included if you
        #   [create a transcription](https://platform.openai.com/docs/api-reference/audio/create-transcription)
        #   with the `include[]` parameter set to `logprobs`.
        #
        #   @return [Array<OpenAI::Models::Audio::TranscriptionTextDoneEvent::Logprob>, nil]
        optional :logprobs,
                 -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Models::Audio::TranscriptionTextDoneEvent::Logprob] }

        # @!method initialize(text:, logprobs: nil, type: :"transcript.text.done")
        #   Emitted when the transcription is complete. Contains the complete transcription
        #   text. Only emitted when you
        #   [create a transcription](https://platform.openai.com/docs/api-reference/audio/create-transcription)
        #   with the `Stream` parameter set to `true`.
        #
        #   @param text [String]
        #   @param logprobs [Array<OpenAI::Models::Audio::TranscriptionTextDoneEvent::Logprob>]
        #   @param type [Symbol, :"transcript.text.done"]

        class Logprob < OpenAI::Internal::Type::BaseModel
          # @!attribute token
          #   The token that was used to generate the log probability.
          #
          #   @return [String, nil]
          optional :token, String

          # @!attribute bytes
          #   The bytes that were used to generate the log probability.
          #
          #   @return [Array<Object>, nil]
          optional :bytes, OpenAI::Internal::Type::ArrayOf[OpenAI::Internal::Type::Unknown]

          # @!attribute logprob
          #   The log probability of the token.
          #
          #   @return [Float, nil]
          optional :logprob, Float

          # @!method initialize(token: nil, bytes: nil, logprob: nil)
          #   @param token [String]
          #   @param bytes [Array<Object>]
          #   @param logprob [Float]
        end
      end
    end
  end
end
