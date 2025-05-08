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
        #   Reasoning text contents.
        #
        #   @return [Array<OpenAI::Responses::ResponseReasoningItem::Summary>]
        required :summary,
                 -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Responses::ResponseReasoningItem::Summary] }

        # @!attribute type
        #   The type of the object. Always `reasoning`.
        #
        #   @return [Symbol, :reasoning]
        required :type, const: :reasoning

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
        #   @return [Symbol, OpenAI::Responses::ResponseReasoningItem::Status, nil]
        optional :status, enum: -> { OpenAI::Responses::ResponseReasoningItem::Status }

        # @!method initialize(id:, summary:, encrypted_content: nil, status: nil, type: :reasoning)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Responses::ResponseReasoningItem} for more details.
        #
        #   A description of the chain of thought used by a reasoning model while generating
        #   a response. Be sure to include these items in your `input` to the Responses API
        #   for subsequent turns of a conversation if you are manually
        #   [managing context](https://platform.openai.com/docs/guides/conversation-state).
        #
        #   @param id [String] The unique identifier of the reasoning content.
        #
        #   @param summary [Array<OpenAI::Responses::ResponseReasoningItem::Summary>] Reasoning text contents.
        #
        #   @param encrypted_content [String, nil] The encrypted content of the reasoning item - populated when a response is
        #
        #   @param status [Symbol, OpenAI::Responses::ResponseReasoningItem::Status] The status of the item. One of `in_progress`, `completed`, or
        #
        #   @param type [Symbol, :reasoning] The type of the object. Always `reasoning`.

        class Summary < OpenAI::Internal::Type::BaseModel
          # @!attribute text
          #   A short summary of the reasoning used by the model when generating the response.
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
          #   {OpenAI::Responses::ResponseReasoningItem::Summary} for more details.
          #
          #   @param text [String] A short summary of the reasoning used by the model when generating
          #
          #   @param type [Symbol, :summary_text] The type of the object. Always `summary_text`.
        end

        # The status of the item. One of `in_progress`, `completed`, or `incomplete`.
        # Populated when items are returned via API.
        #
        # @see OpenAI::Responses::ResponseReasoningItem#status
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
