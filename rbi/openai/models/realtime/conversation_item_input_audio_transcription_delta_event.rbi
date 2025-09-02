# typed: strong

module OpenAI
  module Models
    module Realtime
      class ConversationItemInputAudioTranscriptionDeltaEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::ConversationItemInputAudioTranscriptionDeltaEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The unique ID of the server event.
        sig { returns(String) }
        attr_accessor :event_id

        # The ID of the item.
        sig { returns(String) }
        attr_accessor :item_id

        # The event type, must be `conversation.item.input_audio_transcription.delta`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The index of the content part in the item's content array.
        sig { returns(T.nilable(Integer)) }
        attr_reader :content_index

        sig { params(content_index: Integer).void }
        attr_writer :content_index

        # The text delta.
        sig { returns(T.nilable(String)) }
        attr_reader :delta

        sig { params(delta: String).void }
        attr_writer :delta

        # The log probabilities of the transcription.
        sig do
          returns(T.nilable(T::Array[OpenAI::Realtime::LogProbProperties]))
        end
        attr_accessor :logprobs

        # Returned when the text value of an input audio transcription content part is
        # updated.
        sig do
          params(
            event_id: String,
            item_id: String,
            content_index: Integer,
            delta: String,
            logprobs:
              T.nilable(T::Array[OpenAI::Realtime::LogProbProperties::OrHash]),
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The unique ID of the server event.
          event_id:,
          # The ID of the item.
          item_id:,
          # The index of the content part in the item's content array.
          content_index: nil,
          # The text delta.
          delta: nil,
          # The log probabilities of the transcription.
          logprobs: nil,
          # The event type, must be `conversation.item.input_audio_transcription.delta`.
          type: :"conversation.item.input_audio_transcription.delta"
        )
        end

        sig do
          override.returns(
            {
              event_id: String,
              item_id: String,
              type: Symbol,
              content_index: Integer,
              delta: String,
              logprobs: T.nilable(T::Array[OpenAI::Realtime::LogProbProperties])
            }
          )
        end
        def to_hash
        end
      end
    end
  end
end
