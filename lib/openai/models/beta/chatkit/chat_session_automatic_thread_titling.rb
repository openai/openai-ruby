# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module ChatKit
        class ChatSessionAutomaticThreadTitling < OpenAI::Internal::Type::BaseModel
          # @!attribute enabled
          #   Whether automatic thread titling is enabled.
          #
          #   @return [Boolean]
          required :enabled, OpenAI::Internal::Type::Boolean

          # @!method initialize(enabled:)
          #   Automatic thread title preferences for the session.
          #
          #   @param enabled [Boolean] Whether automatic thread titling is enabled.
        end
      end
    end
  end
end
