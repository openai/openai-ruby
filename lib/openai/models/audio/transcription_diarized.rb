# frozen_string_literal: true

module OpenAI
  module Models
    module Audio
      class TranscriptionDiarized < OpenAI::Internal::Type::BaseModel
        # @!attribute duration
        #   Duration of the input audio in seconds.
        #
        #   @return [Float]
        required :duration, Float

        # @!attribute segments
        #   Segments of the transcript annotated with timestamps and speaker labels.
        #
        #   @return [Array<OpenAI::Models::Audio::TranscriptionDiarizedSegment>]
        required :segments, -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Audio::TranscriptionDiarizedSegment] }

        # @!attribute task
        #   The type of task that was run. Always `transcribe`.
        #
        #   @return [Symbol, :transcribe]
        required :task, const: :transcribe

        # @!attribute text
        #   The concatenated transcript text for the entire audio input.
        #
        #   @return [String]
        required :text, String

        # @!attribute usage
        #   Token or duration usage statistics for the request.
        #
        #   @return [OpenAI::Models::Audio::TranscriptionDiarized::Usage::Tokens, OpenAI::Models::Audio::TranscriptionDiarized::Usage::Duration, nil]
        optional :usage, union: -> { OpenAI::Audio::TranscriptionDiarized::Usage }

        # @!method initialize(duration:, segments:, text:, usage: nil, task: :transcribe)
        #   Represents a diarized transcription response returned by the model, including
        #   the combined transcript and speaker-segment annotations.
        #
        #   @param duration [Float] Duration of the input audio in seconds.
        #
        #   @param segments [Array<OpenAI::Models::Audio::TranscriptionDiarizedSegment>] Segments of the transcript annotated with timestamps and speaker labels.
        #
        #   @param text [String] The concatenated transcript text for the entire audio input.
        #
        #   @param usage [OpenAI::Models::Audio::TranscriptionDiarized::Usage::Tokens, OpenAI::Models::Audio::TranscriptionDiarized::Usage::Duration] Token or duration usage statistics for the request.
        #
        #   @param task [Symbol, :transcribe] The type of task that was run. Always `transcribe`.

        # Token or duration usage statistics for the request.
        #
        # @see OpenAI::Models::Audio::TranscriptionDiarized#usage
        module Usage
          extend OpenAI::Internal::Type::Union

          discriminator :type

          # Usage statistics for models billed by token usage.
          variant :tokens, -> { OpenAI::Audio::TranscriptionDiarized::Usage::Tokens }

          # Usage statistics for models billed by audio input duration.
          variant :duration, -> { OpenAI::Audio::TranscriptionDiarized::Usage::Duration }

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
            #   @return [OpenAI::Models::Audio::TranscriptionDiarized::Usage::Tokens::InputTokenDetails, nil]
            optional :input_token_details,
                     -> { OpenAI::Audio::TranscriptionDiarized::Usage::Tokens::InputTokenDetails }

            # @!method initialize(input_tokens:, output_tokens:, total_tokens:, input_token_details: nil, type: :tokens)
            #   Usage statistics for models billed by token usage.
            #
            #   @param input_tokens [Integer] Number of input tokens billed for this request.
            #
            #   @param output_tokens [Integer] Number of output tokens generated.
            #
            #   @param total_tokens [Integer] Total number of tokens used (input + output).
            #
            #   @param input_token_details [OpenAI::Models::Audio::TranscriptionDiarized::Usage::Tokens::InputTokenDetails] Details about the input tokens billed for this request.
            #
            #   @param type [Symbol, :tokens] The type of the usage object. Always `tokens` for this variant.

            # @see OpenAI::Models::Audio::TranscriptionDiarized::Usage::Tokens#input_token_details
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
          #   @return [Array(OpenAI::Models::Audio::TranscriptionDiarized::Usage::Tokens, OpenAI::Models::Audio::TranscriptionDiarized::Usage::Duration)]
        end
      end
    end
  end
end
