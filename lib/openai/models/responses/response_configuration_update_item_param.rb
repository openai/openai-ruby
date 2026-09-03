# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseConfigurationUpdateItemParam < OpenAI::Internal::Type::BaseModel
        # @!attribute type
        #   The item type. Always `configuration_update`.
        #
        #   @return [Symbol, :configuration_update]
        required :type, const: :configuration_update

        # @!attribute id
        #   The unique ID of the configuration update item.
        #
        #   @return [String, nil]
        optional :id, String, nil?: true

        # @!attribute reasoning
        #   Updates to reasoning configuration. Only effort is supported.
        #
        #   @return [OpenAI::Models::Responses::ResponseConfigurationUpdateItemParam::Reasoning, nil]
        optional :reasoning, -> { OpenAI::Responses::ResponseConfigurationUpdateItemParam::Reasoning }

        # @!method initialize(id: nil, reasoning: nil, type: :configuration_update)
        #   An update to the conversation's response configuration. The configuration
        #   remains in effect for subsequent responses until it is replaced by another
        #   configuration update.
        #
        #   @param id [String, nil] The unique ID of the configuration update item.
        #
        #   @param reasoning [OpenAI::Models::Responses::ResponseConfigurationUpdateItemParam::Reasoning] Updates to reasoning configuration. Only effort is supported.
        #
        #   @param type [Symbol, :configuration_update] The item type. Always `configuration_update`.

        # @see OpenAI::Models::Responses::ResponseConfigurationUpdateItemParam#reasoning
        class Reasoning < OpenAI::Internal::Type::BaseModel
          # @!attribute effort
          #   The reasoning effort to use for subsequent responses until another configuration
          #   update replaces it.
          #
          #   @return [Symbol, OpenAI::Models::ReasoningEffort, nil]
          optional :effort, enum: -> { OpenAI::ReasoningEffort }, nil?: true

          # @!method initialize(effort: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponseConfigurationUpdateItemParam::Reasoning} for
          #   more details.
          #
          #   Updates to reasoning configuration. Only effort is supported.
          #
          #   @param effort [Symbol, OpenAI::Models::ReasoningEffort, nil] The reasoning effort to use for subsequent responses until another
        end
      end
    end
  end
end
