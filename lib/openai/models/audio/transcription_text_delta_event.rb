# frozen_string_literal: true

module OpenAI
  module Models
    module Audio
      class TranscriptionTextDeltaEvent < OpenAI::BaseModel
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

        # @!attribute [r] logprobs
        #   The log probabilities of the delta. Only included if you
        #     [create a transcription](https://platform.openai.com/docs/api-reference/audio/create-transcription)
        #     with the `include[]` parameter set to `logprobs`.
        #
        #   @return [Array<OpenAI::Models::Audio::TranscriptionTextDeltaEvent::Logprob>, nil]
        optional :logprobs, -> { OpenAI::ArrayOf[OpenAI::Models::Audio::TranscriptionTextDeltaEvent::Logprob] }

        # @!parse
        #   # @return [Array<OpenAI::Models::Audio::TranscriptionTextDeltaEvent::Logprob>]
        #   attr_writer :logprobs

        # @!parse
        #   # Emitted when there is an additional text delta. This is also the first event
        #   #   emitted when the transcription starts. Only emitted when you
        #   #   [create a transcription](https://platform.openai.com/docs/api-reference/audio/create-transcription)
        #   #   with the `Stream` parameter set to `true`.
        #   #
        #   # @param delta [String]
        #   # @param logprobs [Array<OpenAI::Models::Audio::TranscriptionTextDeltaEvent::Logprob>]
        #   # @param type [Symbol, :"transcript.text.delta"]
        #   #
        #   def initialize(delta:, logprobs: nil, type: :"transcript.text.delta", **) = super

        # def initialize: (Hash | OpenAI::BaseModel) -> void

        class Logprob < OpenAI::BaseModel
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
          optional :bytes, OpenAI::ArrayOf[OpenAI::Unknown]

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

          # def initialize: (Hash | OpenAI::BaseModel) -> void
        end
      end
    end
  end
end
