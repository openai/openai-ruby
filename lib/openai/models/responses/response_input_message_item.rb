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
        #   @return [Array<OpenAI::Responses::ResponseInputText, OpenAI::Responses::ResponseInputImage, OpenAI::Responses::ResponseInputFile>]
        required :content,
                 -> {
                   OpenAI::Internal::Type::ArrayOf[union: OpenAI::Responses::ResponseInputContent]
                 }

        # @!attribute role
        #   The role of the message input. One of `user`, `system`, or `developer`.
        #
        #   @return [Symbol, OpenAI::Responses::ResponseInputMessageItem::Role]
        required :role, enum: -> { OpenAI::Responses::ResponseInputMessageItem::Role }

        # @!attribute status
        #   The status of item. One of `in_progress`, `completed`, or `incomplete`.
        #   Populated when items are returned via API.
        #
        #   @return [Symbol, OpenAI::Responses::ResponseInputMessageItem::Status, nil]
        optional :status, enum: -> { OpenAI::Responses::ResponseInputMessageItem::Status }

        # @!attribute type
        #   The type of the message input. Always set to `message`.
        #
        #   @return [Symbol, OpenAI::Responses::ResponseInputMessageItem::Type, nil]
        optional :type, enum: -> { OpenAI::Responses::ResponseInputMessageItem::Type }

        # @!method initialize(id:, content:, role:, status: nil, type: nil)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Responses::ResponseInputMessageItem} for more details.
        #
        #   @param id [String] The unique ID of the message input.
        #
        #   @param content [Array<OpenAI::Responses::ResponseInputText, OpenAI::Responses::ResponseInputImage, OpenAI::Responses::ResponseInputFile>] A list of one or many input items to the model, containing different content
        #
        #   @param role [Symbol, OpenAI::Responses::ResponseInputMessageItem::Role] The role of the message input. One of `user`, `system`, or `developer`.
        #
        #   @param status [Symbol, OpenAI::Responses::ResponseInputMessageItem::Status] The status of item. One of `in_progress`, `completed`, or
        #
        #   @param type [Symbol, OpenAI::Responses::ResponseInputMessageItem::Type] The type of the message input. Always set to `message`.

        # The role of the message input. One of `user`, `system`, or `developer`.
        #
        # @see OpenAI::Responses::ResponseInputMessageItem#role
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
        # @see OpenAI::Responses::ResponseInputMessageItem#status
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
        # @see OpenAI::Responses::ResponseInputMessageItem#type
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
