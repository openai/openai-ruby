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
                 -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Audio::TranscriptionTextDoneEvent::Logprob] }

        # @!attribute usage
        #   Usage statistics for models billed by token usage.
        #
        #   @return [OpenAI::Models::Audio::TranscriptionTextDoneEvent::Usage, nil]
        optional :usage, -> { OpenAI::Audio::TranscriptionTextDoneEvent::Usage }

        # @!method initialize(text:, logprobs: nil, usage: nil, type: :"transcript.text.done")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Audio::TranscriptionTextDoneEvent} for more details.
        #
        #   Emitted when the transcription is complete. Contains the complete transcription
        #   text. Only emitted when you
        #   [create a transcription](https://platform.openai.com/docs/api-reference/audio/create-transcription)
        #   with the `Stream` parameter set to `true`.
        #
        #   @param text [String] The text that was transcribed.
        #
        #   @param logprobs [Array<OpenAI::Models::Audio::TranscriptionTextDoneEvent::Logprob>] The log probabilities of the individual tokens in the transcription. Only includ
        #
        #   @param usage [OpenAI::Models::Audio::TranscriptionTextDoneEvent::Usage] Usage statistics for models billed by token usage.
        #
        #   @param type [Symbol, :"transcript.text.done"] The type of the event. Always `transcript.text.done`.

        class Logprob < OpenAI::Internal::Type::BaseModel
          # @!attribute token
          #   The token that was used to generate the log probability.
          #
          #   @return [String, nil]
          optional :token, String

          # @!attribute bytes
          #   The bytes that were used to generate the log probability.
          #
          #   @return [Array<Integer>, nil]
          optional :bytes, OpenAI::Internal::Type::ArrayOf[Integer]

          # @!attribute logprob
          #   The log probability of the token.
          #
          #   @return [Float, nil]
          optional :logprob, Float

          # @!method initialize(token: nil, bytes: nil, logprob: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Audio::TranscriptionTextDoneEvent::Logprob} for more details.
          #
          #   @param token [String] The token that was used to generate the log probability.
          #
          #   @param bytes [Array<Integer>] The bytes that were used to generate the log probability.
          #
          #   @param logprob [Float] The log probability of the token.
        end

        # @see OpenAI::Models::Audio::TranscriptionTextDoneEvent#usage
        class Usage < OpenAI::Internal::Type::BaseModel
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
          #   @return [OpenAI::Models::Audio::TranscriptionTextDoneEvent::Usage::InputTokenDetails, nil]
          optional :input_token_details,
                   -> {
                     OpenAI::Audio::TranscriptionTextDoneEvent::Usage::InputTokenDetails
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
          #   @param input_token_details [OpenAI::Models::Audio::TranscriptionTextDoneEvent::Usage::InputTokenDetails] Details about the input tokens billed for this request.
          #
          #   @param type [Symbol, :tokens] The type of the usage object. Always `tokens` for this variant.

          # @see OpenAI::Models::Audio::TranscriptionTextDoneEvent::Usage#input_token_details
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
      end
    end
  end
end
