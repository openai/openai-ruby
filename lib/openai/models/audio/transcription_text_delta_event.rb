# frozen_string_literal: true

module OpenAI
  module Models
    module Audio
      class TranscriptionTextDeltaEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute delta
        #   The text delta that was additionally transcribed.
        #
        #   @return [String]
        required :delta, String

        # @!attribute type
        #   The type of the event. Always `transcript.text.delta`.
        #
        #   @return [Symbol, :"transcript.text.delta"]
        required :type, const: :"transcript.text.delta"

        # @!attribute logprobs
        #   The log probabilities of the delta. Only included if you
        #   [create a transcription](https://platform.openai.com/docs/api-reference/audio/create-transcription)
        #   with the `include[]` parameter set to `logprobs`.
        #
        #   @return [Array<OpenAI::Models::Audio::TranscriptionTextDeltaEvent::Logprob>, nil]
        optional :logprobs,
                 -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Models::Audio::TranscriptionTextDeltaEvent::Logprob] }

        # @!method initialize(delta:, logprobs: nil, type: :"transcript.text.delta")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Audio::TranscriptionTextDeltaEvent} for more details.
        #
        #   Emitted when there is an additional text delta. This is also the first event
        #   emitted when the transcription starts. Only emitted when you
        #   [create a transcription](https://platform.openai.com/docs/api-reference/audio/create-transcription)
        #   with the `Stream` parameter set to `true`.
        #
        #   @param delta [String] The text delta that was additionally transcribed. ...
        #
        #   @param logprobs [Array<OpenAI::Models::Audio::TranscriptionTextDeltaEvent::Logprob>] The log probabilities of the delta. Only included if you [create a transcription
        #   ...
        #
        #   @param type [Symbol, :"transcript.text.delta"] The type of the event. Always `transcript.text.delta`. ...

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
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Audio::TranscriptionTextDeltaEvent::Logprob} for more details.
          #
          #   @param token [String] The token that was used to generate the log probability. ...
          #
          #   @param bytes [Array<Object>] The bytes that were used to generate the log probability. ...
          #
          #   @param logprob [Float] The log probability of the token. ...
        end
      end
    end
  end
end
