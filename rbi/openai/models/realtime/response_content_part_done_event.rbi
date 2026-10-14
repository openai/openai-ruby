# typed: strong

module OpenAI
  module Models
    module Realtime
      class ResponseContentPartDoneEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::ResponseContentPartDoneEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The index of the content part in the item's content array.
        sig { returns(Integer) }
        attr_accessor :content_index

        # The unique ID of the server event.
        sig { returns(String) }
        attr_accessor :event_id

        # The ID of the item.
        sig { returns(String) }
        attr_accessor :item_id

        # The index of the output item in the response.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The content part that is done.
        sig { returns(OpenAI::Realtime::ResponseContentPartDoneEvent::Part) }
        attr_reader :part

        sig do
          params(
            part: OpenAI::Realtime::ResponseContentPartDoneEvent::Part::OrHash
          ).void
        end
        attr_writer :part

        # The ID of the response.
        sig { returns(String) }
        attr_accessor :response_id

        # The event type, must be `response.content_part.done`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Returned when a content part is done streaming in an assistant message item.
        # Also emitted when a Response is interrupted, incomplete, or cancelled.
        sig do
          params(
            content_index: Integer,
            event_id: String,
            item_id: String,
            output_index: Integer,
            part: OpenAI::Realtime::ResponseContentPartDoneEvent::Part::OrHash,
            response_id: String,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The index of the content part in the item's content array.
          content_index:,
          # The unique ID of the server event.
          event_id:,
          # The ID of the item.
          item_id:,
          # The index of the output item in the response.
          output_index:,
          # The content part that is done.
          part:,
          # The ID of the response.
          response_id:,
          # The event type, must be `response.content_part.done`.
          type: :"response.content_part.done"
        )
        end

        sig do
          override.returns(
            {
              content_index: Integer,
              event_id: String,
              item_id: String,
              output_index: Integer,
              part: OpenAI::Realtime::ResponseContentPartDoneEvent::Part,
              response_id: String,
              type: Symbol
            }
          )
        end
        def to_hash
        end

        class Part < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Realtime::ResponseContentPartDoneEvent::Part,
                OpenAI::Internal::AnyHash
              )
            end

          # Base64-encoded audio data (if type is "audio").
          sig { returns(T.nilable(String)) }
          attr_reader :audio

          sig { params(audio: String).void }
          attr_writer :audio

          # The text content (if type is "text").
          sig { returns(T.nilable(String)) }
          attr_reader :text

          sig { params(text: String).void }
          attr_writer :text

          # The transcript of the audio (if type is "audio").
          sig { returns(T.nilable(String)) }
          attr_reader :transcript

          sig { params(transcript: String).void }
          attr_writer :transcript

          # The content type ("text", "audio").
          sig do
            returns(
              T.nilable(
                OpenAI::Realtime::ResponseContentPartDoneEvent::Part::Type::OrSymbol
              )
            )
          end
          attr_reader :type

          sig do
            params(
              type:
                OpenAI::Realtime::ResponseContentPartDoneEvent::Part::Type::OrSymbol
            ).void
          end
          attr_writer :type

          # The content part that is done.
          sig do
            params(
              audio: String,
              text: String,
              transcript: String,
              type:
                OpenAI::Realtime::ResponseContentPartDoneEvent::Part::Type::OrSymbol
            ).returns(T.attached_class)
          end
          def self.new(
            # Base64-encoded audio data (if type is "audio").
            audio: nil,
            # The text content (if type is "text").
            text: nil,
            # The transcript of the audio (if type is "audio").
            transcript: nil,
            # The content type ("text", "audio").
            type: nil
          )
          end

          sig do
            override.returns(
              {
                audio: String,
                text: String,
                transcript: String,
                type:
                  OpenAI::Realtime::ResponseContentPartDoneEvent::Part::Type::OrSymbol
              }
            )
          end
          def to_hash
          end

          # The content type ("text", "audio").
          module Type
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Realtime::ResponseContentPartDoneEvent::Part::Type
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            TEXT =
              T.let(
                :text,
                OpenAI::Realtime::ResponseContentPartDoneEvent::Part::Type::TaggedSymbol
              )
            AUDIO =
              T.let(
                :audio,
                OpenAI::Realtime::ResponseContentPartDoneEvent::Part::Type::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Realtime::ResponseContentPartDoneEvent::Part::Type::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end
        end
      end
    end
  end
end
