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

        # @!attribute text
        #   The text output configuration for subsequent responses.
        #
        #   @return [OpenAI::Models::Responses::ResponseConfigurationUpdateItem::Text, nil]
        optional :text, -> { OpenAI::Responses::ResponseConfigurationUpdateItem::Text }

        # @!method initialize(id:, reasoning: nil, text: nil, type: :configuration_update)
        #   A configuration update for subsequent responses. Each setting stays in effect
        #   until a later update replaces that setting.
        #
        #   @param id [String]
        #     The unique ID of the configuration update item.
        #
        #   @param reasoning [OpenAI::Models::Responses::ResponseConfigurationUpdateItem::Reasoning]
        #     The reasoning configuration applied by this update.
        #
        #   @param text [OpenAI::Models::Responses::ResponseConfigurationUpdateItem::Text]
        #     The text output configuration for subsequent responses.
        #
        #   @param type [Symbol, :configuration_update]
        #     The item type. Always `configuration_update`.

        # @see OpenAI::Models::Responses::ResponseConfigurationUpdateItem#reasoning
        class Reasoning < OpenAI::Internal::Type::BaseModel
          # @!attribute effort
          #   The reasoning effort used for subsequent responses until another configuration
          #   update replaces it.
          #
          #   @return [Symbol, OpenAI::Models::ReasoningEffort, nil]
          optional :effort, enum: -> { OpenAI::ReasoningEffort }, nil?: true

          # @!method initialize(effort: nil)
          #   The reasoning configuration applied by this update.
          #
          #   @param effort [Symbol, OpenAI::Models::ReasoningEffort, nil]
          #     The reasoning effort used for subsequent responses until another configuration
          #     update replaces it.
        end

        # @see OpenAI::Models::Responses::ResponseConfigurationUpdateItem#text
        class Text < OpenAI::Internal::Type::BaseModel
          # @!attribute format_
          #   Use a JSON schema for structured output or text to return to plain text.
          #
          #   @return [OpenAI::Models::ResponseFormatText, OpenAI::Models::Responses::ResponseFormatTextJSONSchemaConfig]
          required(
            :format_,
            union: -> { OpenAI::Responses::ResponseConfigurationUpdateItem::Text::Format },
            api_name: :format
          )

          # @!method initialize(format_:)
          #   The text output configuration for subsequent responses.
          #
          #   @param format_ [OpenAI::Models::ResponseFormatText, OpenAI::Models::Responses::ResponseFormatTextJSONSchemaConfig]
          #     Use a JSON schema for structured output or text to return to plain text.

          # Use a JSON schema for structured output or text to return to plain text.
          #
          # @see OpenAI::Models::Responses::ResponseConfigurationUpdateItem::Text#format_
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
