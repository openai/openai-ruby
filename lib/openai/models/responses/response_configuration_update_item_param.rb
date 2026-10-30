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

        # @!attribute text
        #   The text output configuration for subsequent responses.
        #
        #   @return [OpenAI::Models::Responses::ResponseConfigurationUpdateItemParam::Text, nil]
        optional :text, -> { OpenAI::Responses::ResponseConfigurationUpdateItemParam::Text }

        # @!method initialize(id: nil, reasoning: nil, text: nil, type: :configuration_update)
        #   An update to the conversation's response configuration. Supply reasoning, text,
        #   or both. Each setting stays in effect until a later update replaces it.
        #
        #   @param id [String, nil]
        #     The unique ID of the configuration update item.
        #
        #   @param reasoning [OpenAI::Models::Responses::ResponseConfigurationUpdateItemParam::Reasoning]
        #     Updates to reasoning configuration. Only effort is supported.
        #
        #   @param text [OpenAI::Models::Responses::ResponseConfigurationUpdateItemParam::Text]
        #     The text output configuration for subsequent responses.
        #
        #   @param type [Symbol, :configuration_update]
        #     The item type. Always `configuration_update`.

        # @see OpenAI::Models::Responses::ResponseConfigurationUpdateItemParam#reasoning
        class Reasoning < OpenAI::Internal::Type::BaseModel
          # @!attribute effort
          #   The reasoning effort to use for subsequent responses until another configuration
          #   update replaces it.
          #
          #   @return [Symbol, OpenAI::Models::ReasoningEffort, nil]
          optional :effort, enum: -> { OpenAI::ReasoningEffort }, nil?: true

          # @!method initialize(effort: nil)
          #   Updates to reasoning configuration. Only effort is supported.
          #
          #   @param effort [Symbol, OpenAI::Models::ReasoningEffort, nil]
          #     The reasoning effort to use for subsequent responses until another configuration
          #     update replaces it.
        end

        # @see OpenAI::Models::Responses::ResponseConfigurationUpdateItemParam#text
        class Text < OpenAI::Internal::Type::BaseModel
          # @!attribute format_
          #   Use a JSON schema for structured output or text to return to plain text.
          #
          #   @return [OpenAI::Models::ResponseFormatText, OpenAI::Models::Responses::ResponseFormatTextJSONSchemaConfig]
          required(
            :format_,
            union: -> { OpenAI::Responses::ResponseConfigurationUpdateItemParam::Text::Format },
            api_name: :format
          )

          # @!method initialize(format_:)
          #   The text output configuration for subsequent responses.
          #
          #   @param format_ [OpenAI::Models::ResponseFormatText, OpenAI::Models::Responses::ResponseFormatTextJSONSchemaConfig]
          #     Use a JSON schema for structured output or text to return to plain text.

          # Use a JSON schema for structured output or text to return to plain text.
          #
          # @see OpenAI::Models::Responses::ResponseConfigurationUpdateItemParam::Text#format_
          module Format
            extend OpenAI::Internal::Type::Union

            discriminator :type

            # Default response format. Used to generate text responses.
            variant :text, -> { OpenAI::ResponseFormatText }

            # JSON Schema response format. Used to generate structured JSON responses.
            # Learn more about [Structured Outputs](https://developers.openai.com/api/docs/guides/structured-outputs).
            variant :json_schema, -> { OpenAI::Responses::ResponseFormatTextJSONSchemaConfig }

            # @!method self.variants
            #   @return [Array(OpenAI::Models::ResponseFormatText, OpenAI::Models::Responses::ResponseFormatTextJSONSchemaConfig)]
          end
        end
      end
    end
  end
end
