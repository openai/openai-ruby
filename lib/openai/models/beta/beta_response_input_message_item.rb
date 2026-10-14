# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class BetaResponseInputMessageItem < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   The unique ID of the message input.
        #
        #   @return [String]
        required :id, String

        # @!attribute content
        #   A list of one or many input items to the model, containing different content
        #   types.
        #
        #   @return [Array<OpenAI::Models::Beta::BetaResponseInputText, OpenAI::Models::Beta::BetaResponseInputImage, OpenAI::Models::Beta::BetaResponseInputFile>]
        required :content, -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::BetaResponseInputContent] }

        # @!attribute role
        #   The role of the message input. One of `user`, `system`, or `developer`.
        #
        #   @return [Symbol, OpenAI::Models::Beta::BetaResponseInputMessageItem::Role]
        required :role, enum: -> { OpenAI::Beta::BetaResponseInputMessageItem::Role }

        # @!attribute type
        #   The type of the message input. Always set to `message`.
        #
        #   @return [Symbol, :message]
        required :type, const: :message

        # @!attribute agent
        #   The agent that produced this item.
        #
        #   @return [OpenAI::Models::Beta::BetaResponseInputMessageItem::Agent, nil]
        optional :agent, -> { OpenAI::Beta::BetaResponseInputMessageItem::Agent }, nil?: true

        # @!attribute status
        #   The status of item. One of `in_progress`, `completed`, or `incomplete`.
        #   Populated when items are returned via API.
        #
        #   @return [Symbol, OpenAI::Models::Beta::BetaResponseInputMessageItem::Status, nil]
        optional :status, enum: -> { OpenAI::Beta::BetaResponseInputMessageItem::Status }

        # @!method initialize(id:, content:, role:, agent: nil, status: nil, type: :message)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Beta::BetaResponseInputMessageItem} for more details.
        #
        #   @param id [String] The unique ID of the message input.
        #
        #   @param content [Array<OpenAI::Models::Beta::BetaResponseInputText, OpenAI::Models::Beta::BetaResponseInputImage, OpenAI::Models::Beta::BetaResponseInputFile>] A list of one or many input items to the model, containing different content
        #
        #   @param role [Symbol, OpenAI::Models::Beta::BetaResponseInputMessageItem::Role] The role of the message input. One of `user`, `system`, or `developer`.
        #
        #   @param agent [OpenAI::Models::Beta::BetaResponseInputMessageItem::Agent, nil] The agent that produced this item.
        #
        #   @param status [Symbol, OpenAI::Models::Beta::BetaResponseInputMessageItem::Status] The status of item. One of `in_progress`, `completed`, or
        #
        #   @param type [Symbol, :message] The type of the message input. Always set to `message`.

        # The role of the message input. One of `user`, `system`, or `developer`.
        #
        # @see OpenAI::Models::Beta::BetaResponseInputMessageItem#role
        module Role
          extend OpenAI::Internal::Type::Enum

          USER = :user
          SYSTEM = :system
          DEVELOPER = :developer

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        # @see OpenAI::Models::Beta::BetaResponseInputMessageItem#agent
        class Agent < OpenAI::Internal::Type::BaseModel
          # @!attribute agent_name
          #   The canonical name of the agent that produced this item.
          #
          #   @return [String]
          required :agent_name, String

          # @!method initialize(agent_name:)
          #   The agent that produced this item.
          #
          #   @param agent_name [String] The canonical name of the agent that produced this item.
        end

        # The status of item. One of `in_progress`, `completed`, or `incomplete`.
        # Populated when items are returned via API.
        #
        # @see OpenAI::Models::Beta::BetaResponseInputMessageItem#status
        module Status
          extend OpenAI::Internal::Type::Enum

          IN_PROGRESS = :in_progress
          COMPLETED = :completed
          INCOMPLETE = :incomplete

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end

    BetaResponseInputMessageItem = Beta::BetaResponseInputMessageItem
  end
end
