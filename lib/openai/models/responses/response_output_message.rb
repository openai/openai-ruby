# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseOutputMessage < OpenAI::BaseModel
        # @!attribute id
        #   The unique ID of the output message.
        #
        #   @return [String]
        required :id, String

        # @!attribute content
        #   The content of the output message.
        #
        #   @return [Array<OpenAI::Models::Responses::ResponseOutputText, OpenAI::Models::Responses::ResponseOutputRefusal>]
        required :content,
                 -> { OpenAI::ArrayOf[union: OpenAI::Models::Responses::ResponseOutputMessage::Content] }

        # @!attribute role
        #   The role of the output message. Always `assistant`.
        #
        #   @return [Symbol, :assistant]
        required :role, const: :assistant

        # @!attribute status
        #   The status of the message input. One of `in_progress`, `completed`, or
        #     `incomplete`. Populated when input items are returned via API.
        #
        #   @return [Symbol, OpenAI::Models::Responses::ResponseOutputMessage::Status]
        required :status, enum: -> { OpenAI::Models::Responses::ResponseOutputMessage::Status }

        # @!attribute type
        #   The type of the output message. Always `message`.
        #
        #   @return [Symbol, :message]
        required :type, const: :message

        # @!parse
        #   # An output message from the model.
        #   #
        #   # @param id [String]
        #   # @param content [Array<OpenAI::Models::Responses::ResponseOutputText, OpenAI::Models::Responses::ResponseOutputRefusal>]
        #   # @param status [Symbol, OpenAI::Models::Responses::ResponseOutputMessage::Status]
        #   # @param role [Symbol, :assistant]
        #   # @param type [Symbol, :message]
        #   #
        #   def initialize(id:, content:, status:, role: :assistant, type: :message, **) = super

        # def initialize: (Hash | OpenAI::BaseModel) -> void

        # A text output from the model.
        module Content
          extend OpenAI::Union

          discriminator :type

          # A text output from the model.
          variant :output_text, -> { OpenAI::Models::Responses::ResponseOutputText }

          # A refusal from the model.
          variant :refusal, -> { OpenAI::Models::Responses::ResponseOutputRefusal }

          # @!parse
          #   class << self
          #     # @return [Array(OpenAI::Models::Responses::ResponseOutputText, OpenAI::Models::Responses::ResponseOutputRefusal)]
          #     def variants; end
          #   end
        end

        # The status of the message input. One of `in_progress`, `completed`, or
        #   `incomplete`. Populated when input items are returned via API.
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
      end
    end
  end
end
