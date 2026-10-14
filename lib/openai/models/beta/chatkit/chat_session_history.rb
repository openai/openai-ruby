# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module ChatKit
        class ChatSessionHistory < OpenAI::Internal::Type::BaseModel
          # @!attribute enabled
          #   Indicates if chat history is persisted for the session.
          #
          #   @return [Boolean]
          required :enabled, OpenAI::Internal::Type::Boolean

          # @!attribute recent_threads
          #   Number of prior threads surfaced in history views. Defaults to null when all
          #   history is retained.
          #
          #   @return [Integer, nil]
          required :recent_threads, Integer, nil?: true

          # @!method initialize(enabled:, recent_threads:)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::ChatKit::ChatSessionHistory} for more details.
          #
          #   History retention preferences returned for the session.
          #
          #   @param enabled [Boolean] Indicates if chat history is persisted for the session.
          #
          #   @param recent_threads [Integer, nil] Number of prior threads surfaced in history views. Defaults to null when all his
        end
      end
    end
  end
end
