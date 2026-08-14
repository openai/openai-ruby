# frozen_string_literal: true

module OpenAI
  module Realtime
    # The wire protocol permits item references in custom response inputs and uses
    # both `type` and `role` to discriminate message items. Keep these generated-model
    # exceptions local to Realtime instead of weakening SDK-wide union behavior.
    module ConversationItem
      class << self
        private def resolve_variant(value)
          return super unless value.is_a?(Hash)

          type = value.fetch(:type) { value.fetch("type", OpenAI::Internal::OMIT) }
          if type.to_s == "item_reference"
            return OpenAI::Realtime::ConversationItemWithReference
          end
          return super unless type.to_s == "message"

          role = value.fetch(:role) { value.fetch("role", OpenAI::Internal::OMIT) }
          case role.to_s
          when "system"
            OpenAI::Realtime::RealtimeConversationItemSystemMessage
          when "user"
            OpenAI::Realtime::RealtimeConversationItemUserMessage
          when "assistant"
            OpenAI::Realtime::RealtimeConversationItemAssistantMessage
          else
            raise ArgumentError, "Realtime message item has an unknown role: #{role.inspect}"
          end
        end
      end
    end
  end
end
