# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class AgentReasoningItem < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   The ID of the reasoning item.
        #
        #   @return [String]
        required :id, String

        # @!attribute status
        #   The status of an agent output item.
        #
        #   @return [Symbol, OpenAI::Models::Beta::AgentOutputItemStatus, nil]
        required :status, enum: -> { OpenAI::Beta::AgentOutputItemStatus }, nil?: true

        # @!attribute summary
        #   The reasoning summaries produced by the agent.
        #
        #   @return [Array<OpenAI::Models::Beta::SummaryText>]
        required :summary, -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Beta::SummaryText] }

        # @!attribute turn_id
        #   The ID of the turn that contains this item.
        #
        #   @return [String]
        required :turn_id, String

        # @!attribute type
        #   The item type. Always `reasoning`.
        #
        #   @return [Symbol, :reasoning]
        required :type, const: :reasoning

        # @!method initialize(id:, status:, summary:, turn_id:, type: :reasoning)
        #   A reasoning item produced by the agent.
        #
        #   @param id [String]
        #     The ID of the reasoning item.
        #
        #   @param status [Symbol, OpenAI::Models::Beta::AgentOutputItemStatus, nil]
        #     The status of an agent output item.
        #
        #   @param summary [Array<OpenAI::Models::Beta::SummaryText>]
        #     The reasoning summaries produced by the agent.
        #
        #   @param turn_id [String]
        #     The ID of the turn that contains this item.
        #
        #   @param type [Symbol, :reasoning]
        #     The item type. Always `reasoning`.
      end
    end
  end
end
