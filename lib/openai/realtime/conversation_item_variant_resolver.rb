# frozen_string_literal: true

module OpenAI
  module Realtime
    # The wire protocol uses both `type` and `role` to discriminate message items.
    # Keep this generated-model exception local to Realtime instead of weakening the
    # discriminator behavior shared by every SDK union.
    module ConversationItem
      class << self
        private def resolve_variant(value)
          return super unless value.is_a?(Hash)

          type = value.fetch(:type) { value.fetch("type", OpenAI::Internal::OMIT) }
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
