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

        # @!attribute usage
        #   Token usage statistics for the request.
        #
        #   @return [OpenAI::Models::Audio::Transcription::Usage::Tokens, OpenAI::Models::Audio::Transcription::Usage::Duration, nil]
        optional :usage, union: -> { OpenAI::Audio::Transcription::Usage }

        # @!method initialize(text:, logprobs: nil, usage: nil)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Audio::Transcription} for more details.
        #
        #   Represents a transcription response returned by model, based on the provided
        #   input.
        #
        #   @param text [String] The transcribed text.
        #
        #   @param logprobs [Array<OpenAI::Models::Audio::Transcription::Logprob>] The log probabilities of the tokens in the transcription. Only returned with the
        #
        #   @param usage [OpenAI::Models::Audio::Transcription::Usage::Tokens, OpenAI::Models::Audio::Transcription::Usage::Duration] Token usage statistics for the request.

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

        # Token usage statistics for the request.
        #
        # @see OpenAI::Models::Audio::Transcription#usage
        module Usage
          extend OpenAI::Internal::Type::Union

          discriminator :type

          # Usage statistics for models billed by token usage.
          variant :tokens, -> { OpenAI::Audio::Transcription::Usage::Tokens }

          # Usage statistics for models billed by audio input duration.
          variant :duration, -> { OpenAI::Audio::Transcription::Usage::Duration }

          class Tokens < OpenAI::Internal::Type::BaseModel
            # @!attribute input_tokens
            #   Number of input tokens billed for this request.
            #
            #   @return [Integer]
            required :input_tokens, Integer

            # @!attribute output_tokens
            #   Number of output tokens generated.
            #
            #   @return [Integer]
            required :output_tokens, Integer

            # @!attribute total_tokens
            #   Total number of tokens used (input + output).
            #
            #   @return [Integer]
            required :total_tokens, Integer

            # @!attribute type
            #   The type of the usage object. Always `tokens` for this variant.
            #
            #   @return [Symbol, :tokens]
            required :type, const: :tokens

            # @!attribute input_token_details
            #   Details about the input tokens billed for this request.
            #
            #   @return [OpenAI::Models::Audio::Transcription::Usage::Tokens::InputTokenDetails, nil]
            optional :input_token_details,
                     -> {
                       OpenAI::Audio::Transcription::Usage::Tokens::InputTokenDetails
                     }

            # @!method initialize(input_tokens:, output_tokens:, total_tokens:, input_token_details: nil, type: :tokens)
            #   Usage statistics for models billed by token usage.
            #
            #   @param input_tokens [Integer] Number of input tokens billed for this request.
            #
            #   @param output_tokens [Integer] Number of output tokens generated.
            #
            #   @param total_tokens [Integer] Total number of tokens used (input + output).
            #
            #   @param input_token_details [OpenAI::Models::Audio::Transcription::Usage::Tokens::InputTokenDetails] Details about the input tokens billed for this request.
            #
            #   @param type [Symbol, :tokens] The type of the usage object. Always `tokens` for this variant.

            # @see OpenAI::Models::Audio::Transcription::Usage::Tokens#input_token_details
            class InputTokenDetails < OpenAI::Internal::Type::BaseModel
              # @!attribute audio_tokens
              #   Number of audio tokens billed for this request.
              #
              #   @return [Integer, nil]
              optional :audio_tokens, Integer

              # @!attribute text_tokens
              #   Number of text tokens billed for this request.
              #
              #   @return [Integer, nil]
              optional :text_tokens, Integer

              # @!method initialize(audio_tokens: nil, text_tokens: nil)
              #   Details about the input tokens billed for this request.
              #
              #   @param audio_tokens [Integer] Number of audio tokens billed for this request.
              #
              #   @param text_tokens [Integer] Number of text tokens billed for this request.
            end
          end

          class Duration < OpenAI::Internal::Type::BaseModel
            # @!attribute seconds
            #   Duration of the input audio in seconds.
            #
            #   @return [Float]
            required :seconds, Float

            # @!attribute type
            #   The type of the usage object. Always `duration` for this variant.
            #
            #   @return [Symbol, :duration]
            required :type, const: :duration

            # @!method initialize(seconds:, type: :duration)
            #   Usage statistics for models billed by audio input duration.
            #
            #   @param seconds [Float] Duration of the input audio in seconds.
            #
            #   @param type [Symbol, :duration] The type of the usage object. Always `duration` for this variant.
          end

          # @!method self.variants
          #   @return [Array(OpenAI::Models::Audio::Transcription::Usage::Tokens, OpenAI::Models::Audio::Transcription::Usage::Duration)]
        end
      end
    end
  end
end
