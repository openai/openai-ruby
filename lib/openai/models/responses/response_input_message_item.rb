# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseInputMessageItem < OpenAI::BaseModel
        # @!attribute id
        #   The unique ID of the message input.
        #
        #   @return [String]
        required :id, String

        # @!attribute content
        #   A list of one or many input items to the model, containing different content
        #     types.
        #
        #   @return [Array<OpenAI::Models::Responses::ResponseInputText, OpenAI::Models::Responses::ResponseInputImage, OpenAI::Models::Responses::ResponseInputFile>]
        required :content, -> { OpenAI::ArrayOf[union: OpenAI::Models::Responses::ResponseInputContent] }

        # @!attribute role
        #   The role of the message input. One of `user`, `system`, or `developer`.
        #
        #   @return [Symbol, OpenAI::Models::Responses::ResponseInputMessageItem::Role]
        required :role, enum: -> { OpenAI::Models::Responses::ResponseInputMessageItem::Role }

        # @!attribute [r] status
        #   The status of item. One of `in_progress`, `completed`, or `incomplete`.
        #     Populated when items are returned via API.
        #
        #   @return [Symbol, OpenAI::Models::Responses::ResponseInputMessageItem::Status, nil]
        optional :status, enum: -> { OpenAI::Models::Responses::ResponseInputMessageItem::Status }

        # @!parse
        #   # @return [Symbol, OpenAI::Models::Responses::ResponseInputMessageItem::Status]
        #   attr_writer :status

        # @!attribute [r] type
        #   The type of the message input. Always set to `message`.
        #
        #   @return [Symbol, OpenAI::Models::Responses::ResponseInputMessageItem::Type, nil]
        optional :type, enum: -> { OpenAI::Models::Responses::ResponseInputMessageItem::Type }

        # @!parse
        #   # @return [Symbol, OpenAI::Models::Responses::ResponseInputMessageItem::Type]
        #   attr_writer :type

        # @!parse
        #   # @param id [String]
        #   # @param content [Array<OpenAI::Models::Responses::ResponseInputText, OpenAI::Models::Responses::ResponseInputImage, OpenAI::Models::Responses::ResponseInputFile>]
        #   # @param role [Symbol, OpenAI::Models::Responses::ResponseInputMessageItem::Role]
        #   # @param status [Symbol, OpenAI::Models::Responses::ResponseInputMessageItem::Status]
        #   # @param type [Symbol, OpenAI::Models::Responses::ResponseInputMessageItem::Type]
        #   #
        #   def initialize(id:, content:, role:, status: nil, type: nil, **) = super

        # def initialize: (Hash | OpenAI::BaseModel) -> void

        # The role of the message input. One of `user`, `system`, or `developer`.
        module Role
          extend OpenAI::Enum

          USER = :user
          SYSTEM = :system
          DEVELOPER = :developer

          finalize!

          class << self
            # @!parse
            #   # @return [Array<Symbol>]
            #   def values; end
          end
        end

        # The status of item. One of `in_progress`, `completed`, or `incomplete`.
        #   Populated when items are returned via API.
        module Status
          extend OpenAI::Enum

          IN_PROGRESS = :in_progress
          COMPLETED = :completed
          INCOMPLETE = :incomplete

          finalize!

          class << self
            # @!parse
            #   # @return [Array<Symbol>]
            #   def values; end
          end
        end

        # The type of the message input. Always set to `message`.
        module Type
          extend OpenAI::Enum

          MESSAGE = :message

          finalize!

          class << self
            # @!parse
            #   # @return [Array<Symbol>]
            #   def values; end
          end
        end
      end
    end
  end
end
