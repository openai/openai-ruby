# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class BetaResponseReasoningItem < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   The unique identifier of the reasoning content.
        #
        #   @return [String]
        required :id, String

        # @!attribute summary
        #   Reasoning summary content.
        #
        #   @return [Array<OpenAI::Models::Beta::BetaResponseReasoningItem::Summary>]
        required :summary,
                 -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Beta::BetaResponseReasoningItem::Summary] }

        # @!attribute type
        #   The type of the object. Always `reasoning`.
        #
        #   @return [Symbol, :reasoning]
        required :type, const: :reasoning

        # @!attribute agent
        #   The agent that produced this item.
        #
        #   @return [OpenAI::Models::Beta::BetaResponseReasoningItem::Agent, nil]
        optional :agent, -> { OpenAI::Beta::BetaResponseReasoningItem::Agent }, nil?: true

        # @!attribute content
        #   Reasoning text content.
        #
        #   @return [Array<OpenAI::Models::Beta::BetaResponseReasoningItem::Content>, nil]
        optional :content,
                 -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Beta::BetaResponseReasoningItem::Content] }

        # @!attribute encrypted_content
        #   The encrypted content of the reasoning item. This is populated by default for
        #   reasoning items returned by `POST /v1/responses` and WebSocket `response.create`
        #   requests.
        #
        #   @return [String, nil]
        optional :encrypted_content, String, nil?: true

        # @!attribute status
        #   The status of the item. One of `in_progress`, `completed`, or `incomplete`.
        #   Populated when items are returned via API.
        #
        #   @return [Symbol, OpenAI::Models::Beta::BetaResponseReasoningItem::Status, nil]
        optional :status, enum: -> { OpenAI::Beta::BetaResponseReasoningItem::Status }

        # @!method initialize(id:, summary:, agent: nil, content: nil, encrypted_content: nil, status: nil, type: :reasoning)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Beta::BetaResponseReasoningItem} for more details.
        #
        #   A description of the chain of thought used by a reasoning model while generating
        #   a response. Be sure to include these items in your `input` to the Responses API
        #   for subsequent turns of a conversation if you are manually
        #   [managing context](https://platform.openai.com/docs/guides/conversation-state).
        #
        #   @param id [String] The unique identifier of the reasoning content.
        #
        #   @param summary [Array<OpenAI::Models::Beta::BetaResponseReasoningItem::Summary>] Reasoning summary content.
        #
        #   @param agent [OpenAI::Models::Beta::BetaResponseReasoningItem::Agent, nil] The agent that produced this item.
        #
        #   @param content [Array<OpenAI::Models::Beta::BetaResponseReasoningItem::Content>] Reasoning text content.
        #
        #   @param encrypted_content [String, nil] The encrypted content of the reasoning item. This is populated by default
        #
        #   @param status [Symbol, OpenAI::Models::Beta::BetaResponseReasoningItem::Status] The status of the item. One of `in_progress`, `completed`, or
        #
        #   @param type [Symbol, :reasoning] The type of the object. Always `reasoning`.

        class Summary < OpenAI::Internal::Type::BaseModel
          # @!attribute text
          #   A summary of the reasoning output from the model so far.
          #
          #   @return [String]
          required :text, String

          # @!attribute type
          #   The type of the object. Always `summary_text`.
          #
          #   @return [Symbol, :summary_text]
          required :type, const: :summary_text

          # @!method initialize(text:, type: :summary_text)
          #   A summary text from the model.
          #
          #   @param text [String] A summary of the reasoning output from the model so far.
          #
          #   @param type [Symbol, :summary_text] The type of the object. Always `summary_text`.
        end

        # @see OpenAI::Models::Beta::BetaResponseReasoningItem#agent
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

        class Content < OpenAI::Internal::Type::BaseModel
          # @!attribute text
          #   The reasoning text from the model.
          #
          #   @return [String]
          required :text, String

          # @!attribute type
          #   The type of the reasoning text. Always `reasoning_text`.
          #
          #   @return [Symbol, :reasoning_text]
          required :type, const: :reasoning_text

          # @!method initialize(text:, type: :reasoning_text)
          #   Reasoning text from the model.
          #
          #   @param text [String] The reasoning text from the model.
          #
          #   @param type [Symbol, :reasoning_text] The type of the reasoning text. Always `reasoning_text`.
        end

        # The status of the item. One of `in_progress`, `completed`, or `incomplete`.
        # Populated when items are returned via API.
        #
        # @see OpenAI::Models::Beta::BetaResponseReasoningItem#status
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

    BetaResponseReasoningItem = Beta::BetaResponseReasoningItem
  end
end
