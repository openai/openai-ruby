# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class EasyInputMessage < OpenAI::Internal::Type::BaseModel
        # @!attribute content
        #   Text, image, or audio input to the model, used to generate a response. Can also
        #   contain previous assistant responses.
        #
        #   @return [String, Array<OpenAI::Models::Responses::ResponseInputText, OpenAI::Models::Responses::ResponseInputImage, OpenAI::Models::Responses::ResponseInputFile>]
        required :content, union: -> { OpenAI::Models::Responses::EasyInputMessage::Content }

        # @!attribute role
        #   The role of the message input. One of `user`, `assistant`, `system`, or
        #   `developer`.
        #
        #   @return [Symbol, OpenAI::Models::Responses::EasyInputMessage::Role]
        required :role, enum: -> { OpenAI::Models::Responses::EasyInputMessage::Role }

        # @!attribute type
        #   The type of the message input. Always `message`.
        #
        #   @return [Symbol, OpenAI::Models::Responses::EasyInputMessage::Type, nil]
        optional :type, enum: -> { OpenAI::Models::Responses::EasyInputMessage::Type }

        # @!method initialize(content:, role:, type: nil)
        #   A message input to the model with a role indicating instruction following
        #   hierarchy. Instructions given with the `developer` or `system` role take
        #   precedence over instructions given with the `user` role. Messages with the
        #   `assistant` role are presumed to have been generated by the model in previous
        #   interactions.
        #
        #   @param content [String, Array<OpenAI::Models::Responses::ResponseInputText, OpenAI::Models::Responses::ResponseInputImage, OpenAI::Models::Responses::ResponseInputFile>]
        #   @param role [Symbol, OpenAI::Models::Responses::EasyInputMessage::Role]
        #   @param type [Symbol, OpenAI::Models::Responses::EasyInputMessage::Type]

        # Text, image, or audio input to the model, used to generate a response. Can also
        # contain previous assistant responses.
        #
        # @see OpenAI::Models::Responses::EasyInputMessage#content
        module Content
          extend OpenAI::Internal::Type::Union

          # A text input to the model.
          variant String

          # A list of one or many input items to the model, containing different content
          # types.
          variant -> { OpenAI::Models::Responses::ResponseInputMessageContentList }

          # @!method self.variants
          #   @return [Array(String, Array<OpenAI::Models::Responses::ResponseInputText, OpenAI::Models::Responses::ResponseInputImage, OpenAI::Models::Responses::ResponseInputFile>)]
        end

        # The role of the message input. One of `user`, `assistant`, `system`, or
        # `developer`.
        #
        # @see OpenAI::Models::Responses::EasyInputMessage#role
        module Role
          extend OpenAI::Internal::Type::Enum

          USER = :user
          ASSISTANT = :assistant
          SYSTEM = :system
          DEVELOPER = :developer

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        # The type of the message input. Always `message`.
        #
        # @see OpenAI::Models::Responses::EasyInputMessage#type
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
