# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class ConversationItemWithReference < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   For an item of type (`message` | `function_call` | `function_call_output`) this
        #   field allows the client to assign the unique ID of the item. It is not required
        #   because the server will generate one if not provided.
        #
        #   For an item of type `item_reference`, this field is required and is a reference
        #   to any item that has previously existed in the conversation.
        #
        #   @return [String, nil]
        optional :id, String

        # @!attribute arguments
        #   The arguments of the function call (for `function_call` items).
        #
        #   @return [String, nil]
        optional :arguments, String

        # @!attribute call_id
        #   The ID of the function call (for `function_call` and `function_call_output`
        #   items). If passed on a `function_call_output` item, the server will check that a
        #   `function_call` item with the same ID exists in the conversation history.
        #
        #   @return [String, nil]
        optional :call_id, String

        # @!attribute content
        #   The content of the message, applicable for `message` items.
        #
        #   - Message items of role `system` support only `input_text` content
        #   - Message items of role `user` support `input_text` and `input_audio` content
        #   - Message items of role `assistant` support `text` content.
        #
        #   @return [Array<OpenAI::Models::Realtime::ConversationItemWithReference::Content>, nil]
        optional :content,
                 -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Realtime::ConversationItemWithReference::Content] }

        # @!attribute name
        #   The name of the function being called (for `function_call` items).
        #
        #   @return [String, nil]
        optional :name, String

        # @!attribute object
        #   Identifier for the API object being returned - always `realtime.item`.
        #
        #   @return [Symbol, OpenAI::Models::Realtime::ConversationItemWithReference::Object, nil]
        optional :object, enum: -> { OpenAI::Realtime::ConversationItemWithReference::Object }

        # @!attribute output
        #   The output of the function call (for `function_call_output` items).
        #
        #   @return [String, nil]
        optional :output, String

        # @!attribute role
        #   The role of the message sender (`user`, `assistant`, `system`), only applicable
        #   for `message` items.
        #
        #   @return [Symbol, OpenAI::Models::Realtime::ConversationItemWithReference::Role, nil]
        optional :role, enum: -> { OpenAI::Realtime::ConversationItemWithReference::Role }

        # @!attribute status
        #   The status of the item (`completed`, `incomplete`, `in_progress`). These have no
        #   effect on the conversation, but are accepted for consistency with the
        #   `conversation.item.created` event.
        #
        #   @return [Symbol, OpenAI::Models::Realtime::ConversationItemWithReference::Status, nil]
        optional :status, enum: -> { OpenAI::Realtime::ConversationItemWithReference::Status }

        # @!attribute type
        #   The type of the item (`message`, `function_call`, `function_call_output`,
        #   `item_reference`).
        #
        #   @return [Symbol, OpenAI::Models::Realtime::ConversationItemWithReference::Type, nil]
        optional :type, enum: -> { OpenAI::Realtime::ConversationItemWithReference::Type }

        # @!method initialize(id: nil, arguments: nil, call_id: nil, content: nil, name: nil, object: nil, output: nil, role: nil, status: nil, type: nil)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Realtime::ConversationItemWithReference} for more details.
        #
        #   The item to add to the conversation.
        #
        #   @param id [String] For an item of type (`message` | `function_call` | `function_call_output`)
        #
        #   @param arguments [String] The arguments of the function call (for `function_call` items).
        #
        #   @param call_id [String] The ID of the function call (for `function_call` and
        #
        #   @param content [Array<OpenAI::Models::Realtime::ConversationItemWithReference::Content>] The content of the message, applicable for `message` items.
        #
        #   @param name [String] The name of the function being called (for `function_call` items).
        #
        #   @param object [Symbol, OpenAI::Models::Realtime::ConversationItemWithReference::Object] Identifier for the API object being returned - always `realtime.item`.
        #
        #   @param output [String] The output of the function call (for `function_call_output` items).
        #
        #   @param role [Symbol, OpenAI::Models::Realtime::ConversationItemWithReference::Role] The role of the message sender (`user`, `assistant`, `system`), only
        #
        #   @param status [Symbol, OpenAI::Models::Realtime::ConversationItemWithReference::Status] The status of the item (`completed`, `incomplete`, `in_progress`). These have no
        #
        #   @param type [Symbol, OpenAI::Models::Realtime::ConversationItemWithReference::Type] The type of the item (`message`, `function_call`, `function_call_output`,
        #   `item\_

        class Content < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #   ID of a previous conversation item to reference (for `item_reference` content
          #   types in `response.create` events). These can reference both client and server
          #   created items.
          #
          #   @return [String, nil]
          optional :id, String

          # @!attribute audio
          #   Base64-encoded audio bytes, used for `input_audio` content type.
          #
          #   @return [String, nil]
          optional :audio, String

          # @!attribute text
          #   The text content, used for `input_text` and `text` content types.
          #
          #   @return [String, nil]
          optional :text, String

          # @!attribute transcript
          #   The transcript of the audio, used for `input_audio` content type.
          #
          #   @return [String, nil]
          optional :transcript, String

          # @!attribute type
          #   The content type (`input_text`, `input_audio`, `item_reference`, `text`).
          #
          #   @return [Symbol, OpenAI::Models::Realtime::ConversationItemWithReference::Content::Type, nil]
          optional :type, enum: -> { OpenAI::Realtime::ConversationItemWithReference::Content::Type }

          # @!method initialize(id: nil, audio: nil, text: nil, transcript: nil, type: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Realtime::ConversationItemWithReference::Content} for more
          #   details.
          #
          #   @param id [String] ID of a previous conversation item to reference (for `item_reference`
          #
          #   @param audio [String] Base64-encoded audio bytes, used for `input_audio` content type.
          #
          #   @param text [String] The text content, used for `input_text` and `text` content types.
          #
          #   @param transcript [String] The transcript of the audio, used for `input_audio` content type.
          #
          #   @param type [Symbol, OpenAI::Models::Realtime::ConversationItemWithReference::Content::Type] The content type (`input_text`, `input_audio`, `item_reference`, `text`).

          # The content type (`input_text`, `input_audio`, `item_reference`, `text`).
          #
          # @see OpenAI::Models::Realtime::ConversationItemWithReference::Content#type
          module Type
            extend OpenAI::Internal::Type::Enum

            INPUT_TEXT = :input_text
            INPUT_AUDIO = :input_audio
            ITEM_REFERENCE = :item_reference
            TEXT = :text

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end

        # Identifier for the API object being returned - always `realtime.item`.
        #
        # @see OpenAI::Models::Realtime::ConversationItemWithReference#object
        module Object
          extend OpenAI::Internal::Type::Enum

          REALTIME_ITEM = :"realtime.item"

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        # The role of the message sender (`user`, `assistant`, `system`), only applicable
        # for `message` items.
        #
        # @see OpenAI::Models::Realtime::ConversationItemWithReference#role
        module Role
          extend OpenAI::Internal::Type::Enum

          USER = :user
          ASSISTANT = :assistant
          SYSTEM = :system

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        # The status of the item (`completed`, `incomplete`, `in_progress`). These have no
        # effect on the conversation, but are accepted for consistency with the
        # `conversation.item.created` event.
        #
        # @see OpenAI::Models::Realtime::ConversationItemWithReference#status
        module Status
          extend OpenAI::Internal::Type::Enum

          COMPLETED = :completed
          INCOMPLETE = :incomplete
          IN_PROGRESS = :in_progress

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        # The type of the item (`message`, `function_call`, `function_call_output`,
        # `item_reference`).
        #
        # @see OpenAI::Models::Realtime::ConversationItemWithReference#type
        module Type
          extend OpenAI::Internal::Type::Enum

          MESSAGE = :message
          FUNCTION_CALL = :function_call
          FUNCTION_CALL_OUTPUT = :function_call_output
          ITEM_REFERENCE = :item_reference

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end
  end
end
