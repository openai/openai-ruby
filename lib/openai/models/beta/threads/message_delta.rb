# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        class MessageDelta < OpenAI::Internal::Type::BaseModel
          # @!attribute content
          #   The content of the message in array of text and/or images.
          #
          #   @return [Array<OpenAI::Models::Beta::Threads::ImageFileDeltaBlock, OpenAI::Models::Beta::Threads::TextDeltaBlock, OpenAI::Models::Beta::Threads::RefusalDeltaBlock, OpenAI::Models::Beta::Threads::ImageURLDeltaBlock>, nil]
          optional :content,
                   -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Models::Beta::Threads::MessageContentDelta] }

          # @!attribute role
          #   The entity that produced the message. One of `user` or `assistant`.
          #
          #   @return [Symbol, OpenAI::Models::Beta::Threads::MessageDelta::Role, nil]
          optional :role, enum: -> { OpenAI::Models::Beta::Threads::MessageDelta::Role }

          # @!method initialize(content: nil, role: nil)
          #   The delta containing the fields that have changed on the Message.
          #
          #   @param content [Array<OpenAI::Models::Beta::Threads::ImageFileDeltaBlock, OpenAI::Models::Beta::Threads::TextDeltaBlock, OpenAI::Models::Beta::Threads::RefusalDeltaBlock, OpenAI::Models::Beta::Threads::ImageURLDeltaBlock>] The content of the message in array of text and/or images.
          #
          #   @param role [Symbol, OpenAI::Models::Beta::Threads::MessageDelta::Role] The entity that produced the message. One of `user` or `assistant`.

          # The entity that produced the message. One of `user` or `assistant`.
          #
          # @see OpenAI::Models::Beta::Threads::MessageDelta#role
          module Role
            extend OpenAI::Internal::Type::Enum

            USER = :user
            ASSISTANT = :assistant

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end
      end
    end
  end
end
