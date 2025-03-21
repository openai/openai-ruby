# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        class MessageDelta < OpenAI::BaseModel
          # @!attribute [r] content
          #   The content of the message in array of text and/or images.
          #
          #   @return [Array<OpenAI::Models::Beta::Threads::ImageFileDeltaBlock, OpenAI::Models::Beta::Threads::TextDeltaBlock, OpenAI::Models::Beta::Threads::RefusalDeltaBlock, OpenAI::Models::Beta::Threads::ImageURLDeltaBlock>, nil]
          optional :content, -> { OpenAI::ArrayOf[union: OpenAI::Models::Beta::Threads::MessageContentDelta] }

          # @!parse
          #   # @return [Array<OpenAI::Models::Beta::Threads::ImageFileDeltaBlock, OpenAI::Models::Beta::Threads::TextDeltaBlock, OpenAI::Models::Beta::Threads::RefusalDeltaBlock, OpenAI::Models::Beta::Threads::ImageURLDeltaBlock>]
          #   attr_writer :content

          # @!attribute [r] role
          #   The entity that produced the message. One of `user` or `assistant`.
          #
          #   @return [Symbol, OpenAI::Models::Beta::Threads::MessageDelta::Role, nil]
          optional :role, enum: -> { OpenAI::Models::Beta::Threads::MessageDelta::Role }

          # @!parse
          #   # @return [Symbol, OpenAI::Models::Beta::Threads::MessageDelta::Role]
          #   attr_writer :role

          # @!parse
          #   # The delta containing the fields that have changed on the Message.
          #   #
          #   # @param content [Array<OpenAI::Models::Beta::Threads::ImageFileDeltaBlock, OpenAI::Models::Beta::Threads::TextDeltaBlock, OpenAI::Models::Beta::Threads::RefusalDeltaBlock, OpenAI::Models::Beta::Threads::ImageURLDeltaBlock>]
          #   # @param role [Symbol, OpenAI::Models::Beta::Threads::MessageDelta::Role]
          #   #
          #   def initialize(content: nil, role: nil, **) = super

          # def initialize: (Hash | OpenAI::BaseModel) -> void

          # The entity that produced the message. One of `user` or `assistant`.
          module Role
            extend OpenAI::Enum

            USER = :user
            ASSISTANT = :assistant

            finalize!

            # @!parse
            #   # @return [Array<Symbol>]
            #   def self.values; end
          end
        end
      end
    end
  end
end
