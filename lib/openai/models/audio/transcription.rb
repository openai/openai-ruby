# frozen_string_literal: true

module OpenAI
  module Models
    module Audio
      class Transcription < OpenAI::Internal::Type::BaseModel
        # @!attribute text
        #   The transcribed text.
        #
        #   @return [String]
        required :text, String

        # @!attribute [r] logprobs
        #   The log probabilities of the tokens in the transcription. Only returned with the
        #   models `gpt-4o-transcribe` and `gpt-4o-mini-transcribe` if `logprobs` is added
        #   to the `include` array.
        #
        #   @return [Array<OpenAI::Models::Audio::Transcription::Logprob>, nil]
        optional :logprobs, -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Models::Audio::Transcription::Logprob] }

        # @!parse
        #   # @return [Array<OpenAI::Models::Audio::Transcription::Logprob>]
        #   attr_writer :logprobs

        # @!method initialize(text:, logprobs: nil)
        #   Represents a transcription response returned by model, based on the provided
        #   input.
        #
        #   @param text [String]
        #   @param logprobs [Array<OpenAI::Models::Audio::Transcription::Logprob>]

        class Logprob < OpenAI::Internal::Type::BaseModel
          # @!attribute [r] token
          #   The token in the transcription.
          #
          #   @return [String, nil]
          optional :token, String

          # @!parse
          #   # @return [String]
          #   attr_writer :token

          # @!attribute [r] bytes
          #   The bytes of the token.
          #
          #   @return [Array<Float>, nil]
          optional :bytes, OpenAI::Internal::Type::ArrayOf[Float]

          # @!parse
          #   # @return [Array<Float>]
          #   attr_writer :bytes

          # @!attribute [r] logprob
          #   The log probability of the token.
          #
          #   @return [Float, nil]
          optional :logprob, Float

          # @!parse
          #   # @return [Float]
          #   attr_writer :logprob

          # @!method initialize(token: nil, bytes: nil, logprob: nil)
          #   @param token [String]
          #   @param bytes [Array<Float>]
          #   @param logprob [Float]
        end
      end
    end
  end
end
