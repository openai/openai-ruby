# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class ConversationItemInputAudioTranscriptionCompletedEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute content_index
        #   The index of the content part containing the audio.
        #
        #   @return [Integer]
        required :content_index, Integer

        # @!attribute event_id
        #   The unique ID of the server event.
        #
        #   @return [String]
        required :event_id, String

        # @!attribute item_id
        #   The ID of the user message item containing the audio.
        #
        #   @return [String]
        required :item_id, String

        # @!attribute transcript
        #   The transcribed text.
        #
        #   @return [String]
        required :transcript, String

        # @!attribute type
        #   The event type, must be `conversation.item.input_audio_transcription.completed`.
        #
        #   @return [Symbol, :"conversation.item.input_audio_transcription.completed"]
        required :type, const: :"conversation.item.input_audio_transcription.completed"

        # @!attribute usage
        #   Usage statistics for the transcription.
        #
        #   @return [OpenAI::Models::Realtime::ConversationItemInputAudioTranscriptionCompletedEvent::Usage::TranscriptTextUsageTokens, OpenAI::Models::Realtime::ConversationItemInputAudioTranscriptionCompletedEvent::Usage::TranscriptTextUsageDuration]
        required :usage,
                 union: -> { OpenAI::Realtime::ConversationItemInputAudioTranscriptionCompletedEvent::Usage }

        # @!attribute logprobs
        #   The log probabilities of the transcription.
        #
        #   @return [Array<OpenAI::Models::Realtime::LogProbProperties>, nil]
        optional :logprobs,
                 -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Realtime::LogProbProperties] },
                 nil?: true

        # @!method initialize(content_index:, event_id:, item_id:, transcript:, usage:, logprobs: nil, type: :"conversation.item.input_audio_transcription.completed")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Realtime::ConversationItemInputAudioTranscriptionCompletedEvent}
        #   for more details.
        #
        #   This event is the output of audio transcription for user audio written to the
        #   user audio buffer. Transcription begins when the input audio buffer is committed
        #   by the client or server (in `server_vad` mode). Transcription runs
        #   asynchronously with Response creation, so this event may come before or after
        #   the Response events.
        #
        #   Realtime API models accept audio natively, and thus input transcription is a
        #   separate process run on a separate ASR (Automatic Speech Recognition) model. The
        #   transcript may diverge somewhat from the model's interpretation, and should be
        #   treated as a rough guide.
        #
        #   @param content_index [Integer] The index of the content part containing the audio.
        #
        #   @param event_id [String] The unique ID of the server event.
        #
        #   @param item_id [String] The ID of the user message item containing the audio.
        #
        #   @param transcript [String] The transcribed text.
        #
        #   @param usage [OpenAI::Models::Realtime::ConversationItemInputAudioTranscriptionCompletedEvent::Usage::TranscriptTextUsageTokens, OpenAI::Models::Realtime::ConversationItemInputAudioTranscriptionCompletedEvent::Usage::TranscriptTextUsageDuration] Usage statistics for the transcription.
        #
        #   @param logprobs [Array<OpenAI::Models::Realtime::LogProbProperties>, nil] The log probabilities of the transcription.
        #
        #   @param type [Symbol, :"conversation.item.input_audio_transcription.completed"] The event type, must be

        # Usage statistics for the transcription.
        #
        # @see OpenAI::Models::Realtime::ConversationItemInputAudioTranscriptionCompletedEvent#usage
        module Usage
          extend OpenAI::Internal::Type::Union

          # Usage statistics for models billed by token usage.
          variant -> { OpenAI::Realtime::ConversationItemInputAudioTranscriptionCompletedEvent::Usage::TranscriptTextUsageTokens }

          # Usage statistics for models billed by audio input duration.
          variant -> { OpenAI::Realtime::ConversationItemInputAudioTranscriptionCompletedEvent::Usage::TranscriptTextUsageDuration }

          class TranscriptTextUsageTokens < OpenAI::Internal::Type::BaseModel
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
            #   @return [OpenAI::Models::Realtime::ConversationItemInputAudioTranscriptionCompletedEvent::Usage::TranscriptTextUsageTokens::InputTokenDetails, nil]
            optional :input_token_details,
                     -> { OpenAI::Realtime::ConversationItemInputAudioTranscriptionCompletedEvent::Usage::TranscriptTextUsageTokens::InputTokenDetails }

            # @!method initialize(input_tokens:, output_tokens:, total_tokens:, input_token_details: nil, type: :tokens)
            #   Usage statistics for models billed by token usage.
            #
            #   @param input_tokens [Integer] Number of input tokens billed for this request.
            #
            #   @param output_tokens [Integer] Number of output tokens generated.
            #
            #   @param total_tokens [Integer] Total number of tokens used (input + output).
            #
            #   @param input_token_details [OpenAI::Models::Realtime::ConversationItemInputAudioTranscriptionCompletedEvent::Usage::TranscriptTextUsageTokens::InputTokenDetails] Details about the input tokens billed for this request.
            #
            #   @param type [Symbol, :tokens] The type of the usage object. Always `tokens` for this variant.

            # @see OpenAI::Models::Realtime::ConversationItemInputAudioTranscriptionCompletedEvent::Usage::TranscriptTextUsageTokens#input_token_details
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

          class TranscriptTextUsageDuration < OpenAI::Internal::Type::BaseModel
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
          #   @return [Array(OpenAI::Models::Realtime::ConversationItemInputAudioTranscriptionCompletedEvent::Usage::TranscriptTextUsageTokens, OpenAI::Models::Realtime::ConversationItemInputAudioTranscriptionCompletedEvent::Usage::TranscriptTextUsageDuration)]
        end
      end
    end
  end
end
