# typed: strong

module OpenAI
  module Models
    module Realtime
      class ConversationItemWithReference < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::ConversationItemWithReference,
              OpenAI::Internal::AnyHash
            )
          end

        # For an item of type (`message` | `function_call` | `function_call_output`) this
        # field allows the client to assign the unique ID of the item. It is not required
        # because the server will generate one if not provided.
        #
        # For an item of type `item_reference`, this field is required and is a reference
        # to any item that has previously existed in the conversation.
        sig { returns(T.nilable(String)) }
        attr_reader :id

        sig { params(id: String).void }
        attr_writer :id

        # The arguments of the function call (for `function_call` items).
        sig { returns(T.nilable(String)) }
        attr_reader :arguments

        sig { params(arguments: String).void }
        attr_writer :arguments

        # The ID of the function call (for `function_call` and `function_call_output`
        # items). If passed on a `function_call_output` item, the server will check that a
        # `function_call` item with the same ID exists in the conversation history.
        sig { returns(T.nilable(String)) }
        attr_reader :call_id

        sig { params(call_id: String).void }
        attr_writer :call_id

        # The content of the message, applicable for `message` items.
        #
        # - Message items of role `system` support only `input_text` content
        # - Message items of role `user` support `input_text` and `input_audio` content
        # - Message items of role `assistant` support `text` content.
        sig do
          returns(
            T.nilable(
              T::Array[OpenAI::Realtime::ConversationItemWithReference::Content]
            )
          )
        end
        attr_reader :content

        sig do
          params(
            content:
              T::Array[
                OpenAI::Realtime::ConversationItemWithReference::Content::OrHash
              ]
          ).void
        end
        attr_writer :content

        # The name of the function being called (for `function_call` items).
        sig { returns(T.nilable(String)) }
        attr_reader :name

        sig { params(name: String).void }
        attr_writer :name

        # Identifier for the API object being returned - always `realtime.item`.
        sig do
          returns(
            T.nilable(
              OpenAI::Realtime::ConversationItemWithReference::Object::OrSymbol
            )
          )
        end
        attr_reader :object

        sig do
          params(
            object:
              OpenAI::Realtime::ConversationItemWithReference::Object::OrSymbol
          ).void
        end
        attr_writer :object

        # The output of the function call (for `function_call_output` items).
        sig { returns(T.nilable(String)) }
        attr_reader :output

        sig { params(output: String).void }
        attr_writer :output

        # The role of the message sender (`user`, `assistant`, `system`), only applicable
        # for `message` items.
        sig do
          returns(
            T.nilable(
              OpenAI::Realtime::ConversationItemWithReference::Role::OrSymbol
            )
          )
        end
        attr_reader :role

        sig do
          params(
            role:
              OpenAI::Realtime::ConversationItemWithReference::Role::OrSymbol
          ).void
        end
        attr_writer :role

        # The status of the item (`completed`, `incomplete`, `in_progress`). These have no
        # effect on the conversation, but are accepted for consistency with the
        # `conversation.item.created` event.
        sig do
          returns(
            T.nilable(
              OpenAI::Realtime::ConversationItemWithReference::Status::OrSymbol
            )
          )
        end
        attr_reader :status

        sig do
          params(
            status:
              OpenAI::Realtime::ConversationItemWithReference::Status::OrSymbol
          ).void
        end
        attr_writer :status

        # The type of the item (`message`, `function_call`, `function_call_output`,
        # `item_reference`).
        sig do
          returns(
            T.nilable(
              OpenAI::Realtime::ConversationItemWithReference::Type::OrSymbol
            )
          )
        end
        attr_reader :type

        sig do
          params(
            type:
              OpenAI::Realtime::ConversationItemWithReference::Type::OrSymbol
          ).void
        end
        attr_writer :type

        # The item to add to the conversation.
        sig do
          params(
            id: String,
            arguments: String,
            call_id: String,
            content:
              T::Array[
                OpenAI::Realtime::ConversationItemWithReference::Content::OrHash
              ],
            name: String,
            object:
              OpenAI::Realtime::ConversationItemWithReference::Object::OrSymbol,
            output: String,
            role:
              OpenAI::Realtime::ConversationItemWithReference::Role::OrSymbol,
            status:
              OpenAI::Realtime::ConversationItemWithReference::Status::OrSymbol,
            type:
              OpenAI::Realtime::ConversationItemWithReference::Type::OrSymbol
          ).returns(T.attached_class)
        end
        def self.new(
          # For an item of type (`message` | `function_call` | `function_call_output`) this
          # field allows the client to assign the unique ID of the item. It is not required
          # because the server will generate one if not provided.
          #
          # For an item of type `item_reference`, this field is required and is a reference
          # to any item that has previously existed in the conversation.
          id: nil,
          # The arguments of the function call (for `function_call` items).
          arguments: nil,
          # The ID of the function call (for `function_call` and `function_call_output`
          # items). If passed on a `function_call_output` item, the server will check that a
          # `function_call` item with the same ID exists in the conversation history.
          call_id: nil,
          # The content of the message, applicable for `message` items.
          #
          # - Message items of role `system` support only `input_text` content
          # - Message items of role `user` support `input_text` and `input_audio` content
          # - Message items of role `assistant` support `text` content.
          content: nil,
          # The name of the function being called (for `function_call` items).
          name: nil,
          # Identifier for the API object being returned - always `realtime.item`.
          object: nil,
          # The output of the function call (for `function_call_output` items).
          output: nil,
          # The role of the message sender (`user`, `assistant`, `system`), only applicable
          # for `message` items.
          role: nil,
          # The status of the item (`completed`, `incomplete`, `in_progress`). These have no
          # effect on the conversation, but are accepted for consistency with the
          # `conversation.item.created` event.
          status: nil,
          # The type of the item (`message`, `function_call`, `function_call_output`,
          # `item_reference`).
          type: nil
        )
        end

        sig do
          override.returns(
            {
              id: String,
              arguments: String,
              call_id: String,
              content:
                T::Array[
                  OpenAI::Realtime::ConversationItemWithReference::Content
                ],
              name: String,
              object:
                OpenAI::Realtime::ConversationItemWithReference::Object::OrSymbol,
              output: String,
              role:
                OpenAI::Realtime::ConversationItemWithReference::Role::OrSymbol,
              status:
                OpenAI::Realtime::ConversationItemWithReference::Status::OrSymbol,
              type:
                OpenAI::Realtime::ConversationItemWithReference::Type::OrSymbol
            }
          )
        end
        def to_hash
        end

        class Content < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Realtime::ConversationItemWithReference::Content,
                OpenAI::Internal::AnyHash
              )
            end

          # ID of a previous conversation item to reference (for `item_reference` content
          # types in `response.create` events). These can reference both client and server
          # created items.
          sig { returns(T.nilable(String)) }
          attr_reader :id

          sig { params(id: String).void }
          attr_writer :id

          # Base64-encoded audio bytes, used for `input_audio` content type.
          sig { returns(T.nilable(String)) }
          attr_reader :audio

          sig { params(audio: String).void }
          attr_writer :audio

          # The text content, used for `input_text` and `text` content types.
          sig { returns(T.nilable(String)) }
          attr_reader :text

          sig { params(text: String).void }
          attr_writer :text

          # The transcript of the audio, used for `input_audio` content type.
          sig { returns(T.nilable(String)) }
          attr_reader :transcript

          sig { params(transcript: String).void }
          attr_writer :transcript

          # The content type (`input_text`, `input_audio`, `item_reference`, `text`).
          sig do
            returns(
              T.nilable(
                OpenAI::Realtime::ConversationItemWithReference::Content::Type::OrSymbol
              )
            )
          end
          attr_reader :type

          sig do
            params(
              type:
                OpenAI::Realtime::ConversationItemWithReference::Content::Type::OrSymbol
            ).void
          end
          attr_writer :type

          sig do
            params(
              id: String,
              audio: String,
              text: String,
              transcript: String,
              type:
                OpenAI::Realtime::ConversationItemWithReference::Content::Type::OrSymbol
            ).returns(T.attached_class)
          end
          def self.new(
            # ID of a previous conversation item to reference (for `item_reference` content
            # types in `response.create` events). These can reference both client and server
            # created items.
            id: nil,
            # Base64-encoded audio bytes, used for `input_audio` content type.
            audio: nil,
            # The text content, used for `input_text` and `text` content types.
            text: nil,
            # The transcript of the audio, used for `input_audio` content type.
            transcript: nil,
            # The content type (`input_text`, `input_audio`, `item_reference`, `text`).
            type: nil
          )
          end

          sig do
            override.returns(
              {
                id: String,
                audio: String,
                text: String,
                transcript: String,
                type:
                  OpenAI::Realtime::ConversationItemWithReference::Content::Type::OrSymbol
              }
            )
          end
          def to_hash
          end

          # The content type (`input_text`, `input_audio`, `item_reference`, `text`).
          module Type
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Realtime::ConversationItemWithReference::Content::Type
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            INPUT_TEXT =
              T.let(
                :input_text,
                OpenAI::Realtime::ConversationItemWithReference::Content::Type::TaggedSymbol
              )
            INPUT_AUDIO =
              T.let(
                :input_audio,
                OpenAI::Realtime::ConversationItemWithReference::Content::Type::TaggedSymbol
              )
            ITEM_REFERENCE =
              T.let(
                :item_reference,
                OpenAI::Realtime::ConversationItemWithReference::Content::Type::TaggedSymbol
              )
            TEXT =
              T.let(
                :text,
                OpenAI::Realtime::ConversationItemWithReference::Content::Type::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Realtime::ConversationItemWithReference::Content::Type::TaggedSymbol
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
                OpenAI::Realtime::ConversationItemWithReference::Object
              )
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          REALTIME_ITEM =
            T.let(
              :"realtime.item",
              OpenAI::Realtime::ConversationItemWithReference::Object::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Realtime::ConversationItemWithReference::Object::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end

        # The role of the message sender (`user`, `assistant`, `system`), only applicable
        # for `message` items.
        module Role
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(
                Symbol,
                OpenAI::Realtime::ConversationItemWithReference::Role
              )
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          USER =
            T.let(
              :user,
              OpenAI::Realtime::ConversationItemWithReference::Role::TaggedSymbol
            )
          ASSISTANT =
            T.let(
              :assistant,
              OpenAI::Realtime::ConversationItemWithReference::Role::TaggedSymbol
            )
          SYSTEM =
            T.let(
              :system,
              OpenAI::Realtime::ConversationItemWithReference::Role::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Realtime::ConversationItemWithReference::Role::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end

        # The status of the item (`completed`, `incomplete`, `in_progress`). These have no
        # effect on the conversation, but are accepted for consistency with the
        # `conversation.item.created` event.
        module Status
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(
                Symbol,
                OpenAI::Realtime::ConversationItemWithReference::Status
              )
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          COMPLETED =
            T.let(
              :completed,
              OpenAI::Realtime::ConversationItemWithReference::Status::TaggedSymbol
            )
          INCOMPLETE =
            T.let(
              :incomplete,
              OpenAI::Realtime::ConversationItemWithReference::Status::TaggedSymbol
            )
          IN_PROGRESS =
            T.let(
              :in_progress,
              OpenAI::Realtime::ConversationItemWithReference::Status::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Realtime::ConversationItemWithReference::Status::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end

        # The type of the item (`message`, `function_call`, `function_call_output`,
        # `item_reference`).
        module Type
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(
                Symbol,
                OpenAI::Realtime::ConversationItemWithReference::Type
              )
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          MESSAGE =
            T.let(
              :message,
              OpenAI::Realtime::ConversationItemWithReference::Type::TaggedSymbol
            )
          FUNCTION_CALL =
            T.let(
              :function_call,
              OpenAI::Realtime::ConversationItemWithReference::Type::TaggedSymbol
            )
          FUNCTION_CALL_OUTPUT =
            T.let(
              :function_call_output,
              OpenAI::Realtime::ConversationItemWithReference::Type::TaggedSymbol
            )
          ITEM_REFERENCE =
            T.let(
              :item_reference,
              OpenAI::Realtime::ConversationItemWithReference::Type::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Realtime::ConversationItemWithReference::Type::TaggedSymbol
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
