# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseInputMessageItem < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   The unique ID of the message input.
        #
        #   @return [String]
        required :id, String

        # @!attribute content
        #   A list of one or many input items to the model, containing different content
        #   types.
        #
        #   @return [Array<OpenAI::Models::Responses::ResponseInputText, OpenAI::Models::Responses::ResponseInputImage, OpenAI::Models::Responses::ResponseInputFile>]
        required :content,
                 -> {
                   OpenAI::Internal::Type::ArrayOf[union: OpenAI::Responses::ResponseInputContent]
                 }

        # @!attribute role
        #   The role of the message input. One of `user`, `system`, or `developer`.
        #
        #   @return [Symbol, OpenAI::Models::Responses::ResponseInputMessageItem::Role]
        required :role, enum: -> { OpenAI::Responses::ResponseInputMessageItem::Role }

        # @!attribute status
        #   The status of item. One of `in_progress`, `completed`, or `incomplete`.
        #   Populated when items are returned via API.
        #
        #   @return [Symbol, OpenAI::Models::Responses::ResponseInputMessageItem::Status, nil]
        optional :status, enum: -> { OpenAI::Responses::ResponseInputMessageItem::Status }

        # @!attribute type
        #   The type of the message input. Always set to `message`.
        #
        #   @return [Symbol, OpenAI::Models::Responses::ResponseInputMessageItem::Type, nil]
        optional :type, enum: -> { OpenAI::Responses::ResponseInputMessageItem::Type }

        # @!method initialize(id:, content:, role:, status: nil, type: nil)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Responses::ResponseInputMessageItem} for more details.
        #
        #   @param id [String] The unique ID of the message input.
        #
        #   @param content [Array<OpenAI::Models::Responses::ResponseInputText, OpenAI::Models::Responses::ResponseInputImage, OpenAI::Models::Responses::ResponseInputFile>] A list of one or many input items to the model, containing different content
        #
        #   @param role [Symbol, OpenAI::Models::Responses::ResponseInputMessageItem::Role] The role of the message input. One of `user`, `system`, or `developer`.
        #
        #   @param status [Symbol, OpenAI::Models::Responses::ResponseInputMessageItem::Status] The status of item. One of `in_progress`, `completed`, or
        #
        #   @param type [Symbol, OpenAI::Models::Responses::ResponseInputMessageItem::Type] The type of the message input. Always set to `message`.

        # The role of the message input. One of `user`, `system`, or `developer`.
        #
        # @see OpenAI::Models::Responses::ResponseInputMessageItem#role
        module Role
          extend OpenAI::Internal::Type::Enum

          USER = :user
          SYSTEM = :system
          DEVELOPER = :developer

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        # The status of item. One of `in_progress`, `completed`, or `incomplete`.
        # Populated when items are returned via API.
        #
        # @see OpenAI::Models::Responses::ResponseInputMessageItem#status
        module Status
          extend OpenAI::Internal::Type::Enum

          IN_PROGRESS = :in_progress
          COMPLETED = :completed
          INCOMPLETE = :incomplete

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        # The type of the message input. Always set to `message`.
        #
        # @see OpenAI::Models::Responses::ResponseInputMessageItem#type
        module Type
          extend OpenAI::Internal::Type::Enum

          MESSAGE = :message

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end
  end
end
