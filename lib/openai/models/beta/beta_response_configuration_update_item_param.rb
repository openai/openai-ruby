# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class BetaResponseConfigurationUpdateItemParam < OpenAI::Internal::Type::BaseModel
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

        # @!attribute agent
        #   The agent that produced this item.
        #
        #   @return [OpenAI::Models::Beta::BetaResponseConfigurationUpdateItemParam::Agent, nil]
        optional :agent, -> { OpenAI::Beta::BetaResponseConfigurationUpdateItemParam::Agent }, nil?: true

        # @!attribute reasoning
        #   Updates to reasoning configuration. Only effort is supported.
        #
        #   @return [OpenAI::Models::Beta::BetaResponseConfigurationUpdateItemParam::Reasoning, nil]
        optional :reasoning, -> { OpenAI::Beta::BetaResponseConfigurationUpdateItemParam::Reasoning }

        # @!attribute text
        #   The text output configuration for subsequent responses.
        #
        #   @return [OpenAI::Models::Beta::BetaResponseConfigurationUpdateItemParam::Text, nil]
        optional :text, -> { OpenAI::Beta::BetaResponseConfigurationUpdateItemParam::Text }

        # @!method initialize(id: nil, agent: nil, reasoning: nil, text: nil, type: :configuration_update)
        #   An update to the conversation's response configuration. Supply reasoning, text,
        #   or both. Each setting stays in effect until a later update replaces it.
        #
        #   @param id [String, nil]
        #     The unique ID of the configuration update item.
        #
        #   @param agent [OpenAI::Models::Beta::BetaResponseConfigurationUpdateItemParam::Agent, nil]
        #     The agent that produced this item.
        #
        #   @param reasoning [OpenAI::Models::Beta::BetaResponseConfigurationUpdateItemParam::Reasoning]
        #     Updates to reasoning configuration. Only effort is supported.
        #
        #   @param text [OpenAI::Models::Beta::BetaResponseConfigurationUpdateItemParam::Text]
        #     The text output configuration for subsequent responses.
        #
        #   @param type [Symbol, :configuration_update]
        #     The item type. Always `configuration_update`.

        # @see OpenAI::Models::Beta::BetaResponseConfigurationUpdateItemParam#agent
        class Agent < OpenAI::Internal::Type::BaseModel
          # @!attribute agent_name
          #   The canonical name of the agent that produced this item.
          #
          #   @return [String]
          required :agent_name, String

          # @!method initialize(agent_name:)
          #   The agent that produced this item.
          #
          #   @param agent_name [String]
          #     The canonical name of the agent that produced this item.
        end

        # @see OpenAI::Models::Beta::BetaResponseConfigurationUpdateItemParam#reasoning
        class Reasoning < OpenAI::Internal::Type::BaseModel
          # @!attribute effort
          #   The reasoning effort to use for subsequent responses until another configuration
          #   update replaces it.
          #
          #   @return [Symbol, OpenAI::Models::Beta::BetaResponseConfigurationUpdateItemParam::Reasoning::Effort, nil]
          optional(
            :effort,
            enum: -> { OpenAI::Beta::BetaResponseConfigurationUpdateItemParam::Reasoning::Effort },
            nil?: true
          )

          # @!method initialize(effort: nil)
          #   Updates to reasoning configuration. Only effort is supported.
          #
          #   @param effort [Symbol, OpenAI::Models::Beta::BetaResponseConfigurationUpdateItemParam::Reasoning::Effort, nil]
          #     The reasoning effort to use for subsequent responses until another configuration
          #     update replaces it.

          # The reasoning effort to use for subsequent responses until another configuration
          # update replaces it.
          #
          # @see OpenAI::Models::Beta::BetaResponseConfigurationUpdateItemParam::Reasoning#effort
          module Effort
            extend OpenAI::Internal::Type::Enum

            NONE = :none
            MINIMAL = :minimal
            LOW = :low
            MEDIUM = :medium
            HIGH = :high
            XHIGH = :xhigh
            MAX = :max

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end

        # @see OpenAI::Models::Beta::BetaResponseConfigurationUpdateItemParam#text
        class Text < OpenAI::Internal::Type::BaseModel
          # @!attribute format_
          #   Use a JSON schema for structured output or text to return to plain text.
          #
          #   @return [OpenAI::Models::Beta::BetaResponseConfigurationUpdateItemParam::Text::Format::Text, OpenAI::Models::Beta::BetaResponseFormatTextJSONSchemaConfig]
          required(
            :format_,
            union: -> { OpenAI::Beta::BetaResponseConfigurationUpdateItemParam::Text::Format },
            api_name: :format
          )

          # @!method initialize(format_:)
          #   The text output configuration for subsequent responses.
          #
          #   @param format_ [OpenAI::Models::Beta::BetaResponseConfigurationUpdateItemParam::Text::Format::Text, OpenAI::Models::Beta::BetaResponseFormatTextJSONSchemaConfig]
          #     Use a JSON schema for structured output or text to return to plain text.

          # Use a JSON schema for structured output or text to return to plain text.
          #
          # @see OpenAI::Models::Beta::BetaResponseConfigurationUpdateItemParam::Text#format_
          module Format
            extend OpenAI::Internal::Type::Union

            discriminator :type

            # Default response format. Used to generate text responses.
            variant :text, -> { OpenAI::Beta::BetaResponseConfigurationUpdateItemParam::Text::Format::Text }

            # JSON Schema response format. Used to generate structured JSON responses.
            # Learn more about [Structured Outputs](https://developers.openai.com/api/docs/guides/structured-outputs).
            variant :json_schema, -> { OpenAI::Beta::BetaResponseFormatTextJSONSchemaConfig }

            class Text < OpenAI::Internal::Type::BaseModel
              # @!attribute type
              #   The type of response format being defined. Always `text`.
              #
              #   @return [Symbol, :text]
              required :type, const: :text

              # @!method initialize(type: :text)
              #   Default response format. Used to generate text responses.
              #
              #   @param type [Symbol, :text]
              #     The type of response format being defined. Always `text`.
            end

            # @!method self.variants
            #   @return [Array(OpenAI::Models::Beta::BetaResponseConfigurationUpdateItemParam::Text::Format::Text, OpenAI::Models::Beta::BetaResponseFormatTextJSONSchemaConfig)]
          end
        end
      end
    end

    BetaResponseConfigurationUpdateItemParam = Beta::BetaResponseConfigurationUpdateItemParam
  end
end
