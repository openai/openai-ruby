# typed: strong

module OpenAI
  module Models
    module Realtime
      class RealtimeConversationItemUserMessage < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::RealtimeConversationItemUserMessage,
              OpenAI::Internal::AnyHash
            )
          end

        # The content of the message.
        sig do
          returns(
            T::Array[
              OpenAI::Realtime::RealtimeConversationItemUserMessage::Content
            ]
          )
        end
        attr_accessor :content

        # The role of the message sender. Always `user`.
        sig { returns(Symbol) }
        attr_accessor :role

        # The type of the item. Always `message`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The unique ID of the item.
        sig { returns(T.nilable(String)) }
        attr_reader :id

        sig { params(id: String).void }
        attr_writer :id

        # Identifier for the API object being returned - always `realtime.item`.
        sig do
          returns(
            T.nilable(
              OpenAI::Realtime::RealtimeConversationItemUserMessage::Object::OrSymbol
            )
          )
        end
        attr_reader :object

        sig do
          params(
            object:
              OpenAI::Realtime::RealtimeConversationItemUserMessage::Object::OrSymbol
          ).void
        end
        attr_writer :object

        # The status of the item. Has no effect on the conversation.
        sig do
          returns(
            T.nilable(
              OpenAI::Realtime::RealtimeConversationItemUserMessage::Status::OrSymbol
            )
          )
        end
        attr_reader :status

        sig do
          params(
            status:
              OpenAI::Realtime::RealtimeConversationItemUserMessage::Status::OrSymbol
          ).void
        end
        attr_writer :status

        # A user message item in a Realtime conversation.
        sig do
          params(
            content:
              T::Array[
                OpenAI::Realtime::RealtimeConversationItemUserMessage::Content::OrHash
              ],
            id: String,
            object:
              OpenAI::Realtime::RealtimeConversationItemUserMessage::Object::OrSymbol,
            status:
              OpenAI::Realtime::RealtimeConversationItemUserMessage::Status::OrSymbol,
            role: Symbol,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The content of the message.
          content:,
          # The unique ID of the item.
          id: nil,
          # Identifier for the API object being returned - always `realtime.item`.
          object: nil,
          # The status of the item. Has no effect on the conversation.
          status: nil,
          # The role of the message sender. Always `user`.
          role: :user,
          # The type of the item. Always `message`.
          type: :message
        )
        end

        sig do
          override.returns(
            {
              content:
                T::Array[
                  OpenAI::Realtime::RealtimeConversationItemUserMessage::Content
                ],
              role: Symbol,
              type: Symbol,
              id: String,
              object:
                OpenAI::Realtime::RealtimeConversationItemUserMessage::Object::OrSymbol,
              status:
                OpenAI::Realtime::RealtimeConversationItemUserMessage::Status::OrSymbol
            }
          )
        end
        def to_hash
        end

        class Content < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Realtime::RealtimeConversationItemUserMessage::Content,
                OpenAI::Internal::AnyHash
              )
            end

          # Base64-encoded audio bytes (for `input_audio`).
          sig { returns(T.nilable(String)) }
          attr_reader :audio

          sig { params(audio: String).void }
          attr_writer :audio

          # The text content (for `input_text`).
          sig { returns(T.nilable(String)) }
          attr_reader :text

          sig { params(text: String).void }
          attr_writer :text

          # Transcript of the audio (for `input_audio`).
          sig { returns(T.nilable(String)) }
          attr_reader :transcript

          sig { params(transcript: String).void }
          attr_writer :transcript

          # The content type (`input_text` or `input_audio`).
          sig do
            returns(
              T.nilable(
                OpenAI::Realtime::RealtimeConversationItemUserMessage::Content::Type::OrSymbol
              )
            )
          end
          attr_reader :type

          sig do
            params(
              type:
                OpenAI::Realtime::RealtimeConversationItemUserMessage::Content::Type::OrSymbol
            ).void
          end
          attr_writer :type

          sig do
            params(
              audio: String,
              text: String,
              transcript: String,
              type:
                OpenAI::Realtime::RealtimeConversationItemUserMessage::Content::Type::OrSymbol
            ).returns(T.attached_class)
          end
          def self.new(
            # Base64-encoded audio bytes (for `input_audio`).
            audio: nil,
            # The text content (for `input_text`).
            text: nil,
            # Transcript of the audio (for `input_audio`).
            transcript: nil,
            # The content type (`input_text` or `input_audio`).
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
                  OpenAI::Realtime::RealtimeConversationItemUserMessage::Content::Type::OrSymbol
              }
            )
          end
          def to_hash
          end

          # The content type (`input_text` or `input_audio`).
          module Type
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Realtime::RealtimeConversationItemUserMessage::Content::Type
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            INPUT_TEXT =
              T.let(
                :input_text,
                OpenAI::Realtime::RealtimeConversationItemUserMessage::Content::Type::TaggedSymbol
              )
            INPUT_AUDIO =
              T.let(
                :input_audio,
                OpenAI::Realtime::RealtimeConversationItemUserMessage::Content::Type::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Realtime::RealtimeConversationItemUserMessage::Content::Type::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end
        end

        # Identifier for the API object being returned - always `realtime.item`.
        module Object
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(
                Symbol,
                OpenAI::Realtime::RealtimeConversationItemUserMessage::Object
              )
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          REALTIME_ITEM =
            T.let(
              :"realtime.item",
              OpenAI::Realtime::RealtimeConversationItemUserMessage::Object::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Realtime::RealtimeConversationItemUserMessage::Object::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end

        # The status of the item. Has no effect on the conversation.
        module Status
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(
                Symbol,
                OpenAI::Realtime::RealtimeConversationItemUserMessage::Status
              )
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          COMPLETED =
            T.let(
              :completed,
              OpenAI::Realtime::RealtimeConversationItemUserMessage::Status::TaggedSymbol
            )
          INCOMPLETE =
            T.let(
              :incomplete,
              OpenAI::Realtime::RealtimeConversationItemUserMessage::Status::TaggedSymbol
            )
          IN_PROGRESS =
            T.let(
              :in_progress,
              OpenAI::Realtime::RealtimeConversationItemUserMessage::Status::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Realtime::RealtimeConversationItemUserMessage::Status::TaggedSymbol
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
