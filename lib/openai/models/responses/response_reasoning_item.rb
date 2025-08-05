# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseReasoningItem < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   The unique identifier of the reasoning content.
        #
        #   @return [String]
        required :id, String

        # @!attribute summary
        #   Reasoning summary content.
        #
        #   @return [Array<OpenAI::Models::Responses::ResponseReasoningItem::Summary>]
        required :summary,
                 -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Responses::ResponseReasoningItem::Summary] }

        # @!attribute type
        #   The type of the object. Always `reasoning`.
        #
        #   @return [Symbol, :reasoning]
        required :type, const: :reasoning

        # @!attribute content
        #   Reasoning text content.
        #
        #   @return [Array<OpenAI::Models::Responses::ResponseReasoningItem::Content>, nil]
        optional :content,
                 -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Responses::ResponseReasoningItem::Content] }

        # @!attribute encrypted_content
        #   The encrypted content of the reasoning item - populated when a response is
        #   generated with `reasoning.encrypted_content` in the `include` parameter.
        #
        #   @return [String, nil]
        optional :encrypted_content, String, nil?: true

        # @!attribute status
        #   The status of the item. One of `in_progress`, `completed`, or `incomplete`.
        #   Populated when items are returned via API.
        #
        #   @return [Symbol, OpenAI::Models::Responses::ResponseReasoningItem::Status, nil]
        optional :status, enum: -> { OpenAI::Responses::ResponseReasoningItem::Status }

        # @!method initialize(id:, summary:, content: nil, encrypted_content: nil, status: nil, type: :reasoning)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Responses::ResponseReasoningItem} for more details.
        #
        #   A description of the chain of thought used by a reasoning model while generating
        #   a response. Be sure to include these items in your `input` to the Responses API
        #   for subsequent turns of a conversation if you are manually
        #   [managing context](https://platform.openai.com/docs/guides/conversation-state).
        #
        #   @param id [String] The unique identifier of the reasoning content.
        #
        #   @param summary [Array<OpenAI::Models::Responses::ResponseReasoningItem::Summary>] Reasoning summary content.
        #
        #   @param content [Array<OpenAI::Models::Responses::ResponseReasoningItem::Content>] Reasoning text content.
        #
        #   @param encrypted_content [String, nil] The encrypted content of the reasoning item - populated when a response is
        #
        #   @param status [Symbol, OpenAI::Models::Responses::ResponseReasoningItem::Status] The status of the item. One of `in_progress`, `completed`, or
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
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponseReasoningItem::Summary} for more details.
          #
          #   @param text [String] A summary of the reasoning output from the model so far.
          #
          #   @param type [Symbol, :summary_text] The type of the object. Always `summary_text`.
        end

        class Content < OpenAI::Internal::Type::BaseModel
          # @!attribute text
          #   Reasoning text output from the model.
          #
          #   @return [String]
          required :text, String

          # @!attribute type
          #   The type of the object. Always `reasoning_text`.
          #
          #   @return [Symbol, :reasoning_text]
          required :type, const: :reasoning_text

          # @!method initialize(text:, type: :reasoning_text)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponseReasoningItem::Content} for more details.
          #
          #   @param text [String] Reasoning text output from the model.
          #
          #   @param type [Symbol, :reasoning_text] The type of the object. Always `reasoning_text`.
        end

        # The status of the item. One of `in_progress`, `completed`, or `incomplete`.
        # Populated when items are returned via API.
        #
        # @see OpenAI::Models::Responses::ResponseReasoningItem#status
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
  end
end
