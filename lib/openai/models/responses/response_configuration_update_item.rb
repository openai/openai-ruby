# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseConfigurationUpdateItem < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   The unique ID of the configuration update item.
        #
        #   @return [String]
        required :id, String

        # @!attribute type
        #   The item type. Always `configuration_update`.
        #
        #   @return [Symbol, :configuration_update]
        required :type, const: :configuration_update

        # @!attribute reasoning
        #   The reasoning configuration applied by this update.
        #
        #   @return [OpenAI::Models::Responses::ResponseConfigurationUpdateItem::Reasoning, nil]
        optional :reasoning, -> { OpenAI::Responses::ResponseConfigurationUpdateItem::Reasoning }

        # @!method initialize(id:, reasoning: nil, type: :configuration_update)
        #   A configuration update that applies to subsequent responses until it is replaced
        #   by another configuration update.
        #
        #   @param id [String] The unique ID of the configuration update item.
        #
        #   @param reasoning [OpenAI::Models::Responses::ResponseConfigurationUpdateItem::Reasoning] The reasoning configuration applied by this update.
        #
        #   @param type [Symbol, :configuration_update] The item type. Always `configuration_update`.

        # @see OpenAI::Models::Responses::ResponseConfigurationUpdateItem#reasoning
        class Reasoning < OpenAI::Internal::Type::BaseModel
          # @!attribute effort
          #   The reasoning effort used for subsequent responses until another configuration
          #   update replaces it.
          #
          #   @return [Symbol, OpenAI::Models::ReasoningEffort, nil]
          optional :effort, enum: -> { OpenAI::ReasoningEffort }, nil?: true

          # @!method initialize(effort: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponseConfigurationUpdateItem::Reasoning} for more
          #   details.
          #
          #   The reasoning configuration applied by this update.
          #
          #   @param effort [Symbol, OpenAI::Models::ReasoningEffort, nil] The reasoning effort used for subsequent responses until another
        end
      end
    end
  end
end
