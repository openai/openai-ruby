# typed: strong

module OpenAI
  module Models
    module Realtime
      class RealtimeConversationItemSystemMessage < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::RealtimeConversationItemSystemMessage,
              OpenAI::Internal::AnyHash
            )
          end

        # The content of the message.
        sig do
          returns(
            T::Array[
              OpenAI::Realtime::RealtimeConversationItemSystemMessage::Content
            ]
          )
        end
        attr_accessor :content

        # The role of the message sender. Always `system`.
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
              OpenAI::Realtime::RealtimeConversationItemSystemMessage::Object::OrSymbol
            )
          )
        end
        attr_reader :object

        sig do
          params(
            object:
              OpenAI::Realtime::RealtimeConversationItemSystemMessage::Object::OrSymbol
          ).void
        end
        attr_writer :object

        # The status of the item. Has no effect on the conversation.
        sig do
          returns(
            T.nilable(
              OpenAI::Realtime::RealtimeConversationItemSystemMessage::Status::OrSymbol
            )
          )
        end
        attr_reader :status

        sig do
          params(
            status:
              OpenAI::Realtime::RealtimeConversationItemSystemMessage::Status::OrSymbol
          ).void
        end
        attr_writer :status

        # A system message item in a Realtime conversation.
        sig do
          params(
            content:
              T::Array[
                OpenAI::Realtime::RealtimeConversationItemSystemMessage::Content::OrHash
              ],
            id: String,
            object:
              OpenAI::Realtime::RealtimeConversationItemSystemMessage::Object::OrSymbol,
            status:
              OpenAI::Realtime::RealtimeConversationItemSystemMessage::Status::OrSymbol,
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
          # The role of the message sender. Always `system`.
          role: :system,
          # The type of the item. Always `message`.
          type: :message
        )
        end

        sig do
          override.returns(
            {
              content:
                T::Array[
                  OpenAI::Realtime::RealtimeConversationItemSystemMessage::Content
                ],
              role: Symbol,
              type: Symbol,
              id: String,
              object:
                OpenAI::Realtime::RealtimeConversationItemSystemMessage::Object::OrSymbol,
              status:
                OpenAI::Realtime::RealtimeConversationItemSystemMessage::Status::OrSymbol
            }
          )
        end
        def to_hash
        end

        class Content < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Realtime::RealtimeConversationItemSystemMessage::Content,
                OpenAI::Internal::AnyHash
              )
            end

          # The text content.
          sig { returns(T.nilable(String)) }
          attr_reader :text

          sig { params(text: String).void }
          attr_writer :text

          # The content type. Always `input_text` for system messages.
          sig do
            returns(
              T.nilable(
                OpenAI::Realtime::RealtimeConversationItemSystemMessage::Content::Type::OrSymbol
              )
            )
          end
          attr_reader :type

          sig do
            params(
              type:
                OpenAI::Realtime::RealtimeConversationItemSystemMessage::Content::Type::OrSymbol
            ).void
          end
          attr_writer :type

          sig do
            params(
              text: String,
              type:
                OpenAI::Realtime::RealtimeConversationItemSystemMessage::Content::Type::OrSymbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The text content.
            text: nil,
            # The content type. Always `input_text` for system messages.
            type: nil
          )
          end

          sig do
            override.returns(
              {
                text: String,
                type:
                  OpenAI::Realtime::RealtimeConversationItemSystemMessage::Content::Type::OrSymbol
              }
            )
          end
          def to_hash
          end

          # The content type. Always `input_text` for system messages.
          module Type
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Realtime::RealtimeConversationItemSystemMessage::Content::Type
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            INPUT_TEXT =
              T.let(
                :input_text,
                OpenAI::Realtime::RealtimeConversationItemSystemMessage::Content::Type::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Realtime::RealtimeConversationItemSystemMessage::Content::Type::TaggedSymbol
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
                OpenAI::Realtime::RealtimeConversationItemSystemMessage::Object
              )
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          REALTIME_ITEM =
            T.let(
              :"realtime.item",
              OpenAI::Realtime::RealtimeConversationItemSystemMessage::Object::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Realtime::RealtimeConversationItemSystemMessage::Object::TaggedSymbol
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
                OpenAI::Realtime::RealtimeConversationItemSystemMessage::Status
              )
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          COMPLETED =
            T.let(
              :completed,
              OpenAI::Realtime::RealtimeConversationItemSystemMessage::Status::TaggedSymbol
            )
          INCOMPLETE =
            T.let(
              :incomplete,
              OpenAI::Realtime::RealtimeConversationItemSystemMessage::Status::TaggedSymbol
            )
          IN_PROGRESS =
            T.let(
              :in_progress,
              OpenAI::Realtime::RealtimeConversationItemSystemMessage::Status::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Realtime::RealtimeConversationItemSystemMessage::Status::TaggedSymbol
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
