# typed: strong

module OpenAI
  module Models
    module Realtime
      class ResponseContentPartAddedEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::ResponseContentPartAddedEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The index of the content part in the item's content array.
        sig { returns(Integer) }
        attr_accessor :content_index

        # The unique ID of the server event.
        sig { returns(String) }
        attr_accessor :event_id

        # The ID of the item to which the content part was added.
        sig { returns(String) }
        attr_accessor :item_id

        # The index of the output item in the response.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The content part that was added.
        sig { returns(OpenAI::Realtime::ResponseContentPartAddedEvent::Part) }
        attr_reader :part

        sig do
          params(
            part: OpenAI::Realtime::ResponseContentPartAddedEvent::Part::OrHash
          ).void
        end
        attr_writer :part

        # The ID of the response.
        sig { returns(String) }
        attr_accessor :response_id

        # The event type, must be `response.content_part.added`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Returned when a new content part is added to an assistant message item during
        # response generation.
        sig do
          params(
            content_index: Integer,
            event_id: String,
            item_id: String,
            output_index: Integer,
            part: OpenAI::Realtime::ResponseContentPartAddedEvent::Part::OrHash,
            response_id: String,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The index of the content part in the item's content array.
          content_index:,
          # The unique ID of the server event.
          event_id:,
          # The ID of the item to which the content part was added.
          item_id:,
          # The index of the output item in the response.
          output_index:,
          # The content part that was added.
          part:,
          # The ID of the response.
          response_id:,
          # The event type, must be `response.content_part.added`.
          type: :"response.content_part.added"
        )
        end

        sig do
          override.returns(
            {
              content_index: Integer,
              event_id: String,
              item_id: String,
              output_index: Integer,
              part: OpenAI::Realtime::ResponseContentPartAddedEvent::Part,
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
                OpenAI::Realtime::ResponseContentPartAddedEvent::Part,
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
                OpenAI::Realtime::ResponseContentPartAddedEvent::Part::Type::OrSymbol
              )
            )
          end
          attr_reader :type

          sig do
            params(
              type:
                OpenAI::Realtime::ResponseContentPartAddedEvent::Part::Type::OrSymbol
            ).void
          end
          attr_writer :type

          # The content part that was added.
          sig do
            params(
              audio: String,
              text: String,
              transcript: String,
              type:
                OpenAI::Realtime::ResponseContentPartAddedEvent::Part::Type::OrSymbol
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
                  OpenAI::Realtime::ResponseContentPartAddedEvent::Part::Type::OrSymbol
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
                  OpenAI::Realtime::ResponseContentPartAddedEvent::Part::Type
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            TEXT =
              T.let(
                :text,
                OpenAI::Realtime::ResponseContentPartAddedEvent::Part::Type::TaggedSymbol
              )
            AUDIO =
              T.let(
                :audio,
                OpenAI::Realtime::ResponseContentPartAddedEvent::Part::Type::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Realtime::ResponseContentPartAddedEvent::Part::Type::TaggedSymbol
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
