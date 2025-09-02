# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class RealtimeConversationItemUserMessage < OpenAI::Internal::Type::BaseModel
        # @!attribute content
        #   The content of the message.
        #
        #   @return [Array<OpenAI::Models::Realtime::RealtimeConversationItemUserMessage::Content>]
        required :content,
                 -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Realtime::RealtimeConversationItemUserMessage::Content] }

        # @!attribute role
        #   The role of the message sender. Always `user`.
        #
        #   @return [Symbol, :user]
        required :role, const: :user

        # @!attribute type
        #   The type of the item. Always `message`.
        #
        #   @return [Symbol, :message]
        required :type, const: :message

        # @!attribute id
        #   The unique ID of the item.
        #
        #   @return [String, nil]
        optional :id, String

        # @!attribute object
        #   Identifier for the API object being returned - always `realtime.item`.
        #
        #   @return [Symbol, OpenAI::Models::Realtime::RealtimeConversationItemUserMessage::Object, nil]
        optional :object, enum: -> { OpenAI::Realtime::RealtimeConversationItemUserMessage::Object }

        # @!attribute status
        #   The status of the item. Has no effect on the conversation.
        #
        #   @return [Symbol, OpenAI::Models::Realtime::RealtimeConversationItemUserMessage::Status, nil]
        optional :status, enum: -> { OpenAI::Realtime::RealtimeConversationItemUserMessage::Status }

        # @!method initialize(content:, id: nil, object: nil, status: nil, role: :user, type: :message)
        #   A user message item in a Realtime conversation.
        #
        #   @param content [Array<OpenAI::Models::Realtime::RealtimeConversationItemUserMessage::Content>] The content of the message.
        #
        #   @param id [String] The unique ID of the item.
        #
        #   @param object [Symbol, OpenAI::Models::Realtime::RealtimeConversationItemUserMessage::Object] Identifier for the API object being returned - always `realtime.item`.
        #
        #   @param status [Symbol, OpenAI::Models::Realtime::RealtimeConversationItemUserMessage::Status] The status of the item. Has no effect on the conversation.
        #
        #   @param role [Symbol, :user] The role of the message sender. Always `user`.
        #
        #   @param type [Symbol, :message] The type of the item. Always `message`.

        class Content < OpenAI::Internal::Type::BaseModel
          # @!attribute audio
          #   Base64-encoded audio bytes (for `input_audio`).
          #
          #   @return [String, nil]
          optional :audio, String

          # @!attribute text
          #   The text content (for `input_text`).
          #
          #   @return [String, nil]
          optional :text, String

          # @!attribute transcript
          #   Transcript of the audio (for `input_audio`).
          #
          #   @return [String, nil]
          optional :transcript, String

          # @!attribute type
          #   The content type (`input_text` or `input_audio`).
          #
          #   @return [Symbol, OpenAI::Models::Realtime::RealtimeConversationItemUserMessage::Content::Type, nil]
          optional :type, enum: -> { OpenAI::Realtime::RealtimeConversationItemUserMessage::Content::Type }

          # @!method initialize(audio: nil, text: nil, transcript: nil, type: nil)
          #   @param audio [String] Base64-encoded audio bytes (for `input_audio`).
          #
          #   @param text [String] The text content (for `input_text`).
          #
          #   @param transcript [String] Transcript of the audio (for `input_audio`).
          #
          #   @param type [Symbol, OpenAI::Models::Realtime::RealtimeConversationItemUserMessage::Content::Type] The content type (`input_text` or `input_audio`).

          # The content type (`input_text` or `input_audio`).
          #
          # @see OpenAI::Models::Realtime::RealtimeConversationItemUserMessage::Content#type
          module Type
            extend OpenAI::Internal::Type::Enum

            INPUT_TEXT = :input_text
            INPUT_AUDIO = :input_audio

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end

        # Identifier for the API object being returned - always `realtime.item`.
        #
        # @see OpenAI::Models::Realtime::RealtimeConversationItemUserMessage#object
        module Object
          extend OpenAI::Internal::Type::Enum

          REALTIME_ITEM = :"realtime.item"

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        # The status of the item. Has no effect on the conversation.
        #
        # @see OpenAI::Models::Realtime::RealtimeConversationItemUserMessage#status
        module Status
          extend OpenAI::Internal::Type::Enum

          COMPLETED = :completed
          INCOMPLETE = :incomplete
          IN_PROGRESS = :in_progress

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end
  end
end
