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

        # @!attribute logprobs
        #   The log probabilities of the tokens in the transcription. Only returned with the
        #   models `gpt-4o-transcribe` and `gpt-4o-mini-transcribe` if `logprobs` is added
        #   to the `include` array.
        #
        #   @return [Array<OpenAI::Models::Audio::Transcription::Logprob>, nil]
        optional :logprobs, -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Audio::Transcription::Logprob] }

        # @!method initialize(text:, logprobs: nil)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Audio::Transcription} for more details.
        #
        #   Represents a transcription response returned by model, based on the provided
        #   input.
        #
        #   @param text [String] The transcribed text.
        #
        #   @param logprobs [Array<OpenAI::Models::Audio::Transcription::Logprob>] The log probabilities of the tokens in the transcription. Only returned with the

        class Logprob < OpenAI::Internal::Type::BaseModel
          # @!attribute token
          #   The token in the transcription.
          #
          #   @return [String, nil]
          optional :token, String

          # @!attribute bytes
          #   The bytes of the token.
          #
          #   @return [Array<Float>, nil]
          optional :bytes, OpenAI::Internal::Type::ArrayOf[Float]

          # @!attribute logprob
          #   The log probability of the token.
          #
          #   @return [Float, nil]
          optional :logprob, Float

          # @!method initialize(token: nil, bytes: nil, logprob: nil)
          #   @param token [String] The token in the transcription.
          #
          #   @param bytes [Array<Float>] The bytes of the token.
          #
          #   @param logprob [Float] The log probability of the token.
        end
      end
    end
  end
end
