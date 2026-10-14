# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ToolChoiceAllowed < OpenAI::Internal::Type::BaseModel
        # @!attribute mode
        #   Constrains the tools available to the model to a pre-defined set.
        #
        #   `auto` allows the model to pick from among the allowed tools and generate a
        #   message.
        #
        #   `required` requires the model to call one or more of the allowed tools.
        #
        #   @return [Symbol, OpenAI::Models::Responses::ToolChoiceAllowed::Mode]
        required :mode, enum: -> { OpenAI::Responses::ToolChoiceAllowed::Mode }

        # @!attribute tools
        #   A list of tool definitions that the model should be allowed to call.
        #
        #   For the Responses API, the list of tool definitions might look like:
        #
        #   ```json
        #   [
        #     { "type": "function", "name": "get_weather" },
        #     { "type": "mcp", "server_label": "deepwiki" },
        #     { "type": "image_generation" }
        #   ]
        #   ```
        #
        #   @return [Array<Hash{Symbol=>Object}>]
        required :tools,
                 OpenAI::Internal::Type::ArrayOf[OpenAI::Internal::Type::HashOf[OpenAI::Internal::Type::Unknown]]

        # @!attribute type
        #   Allowed tool configuration type. Always `allowed_tools`.
        #
        #   @return [Symbol, :allowed_tools]
        required :type, const: :allowed_tools

        # @!method initialize(mode:, tools:, type: :allowed_tools)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Responses::ToolChoiceAllowed} for more details.
        #
        #   Constrains the tools available to the model to a pre-defined set.
        #
        #   @param mode [Symbol, OpenAI::Models::Responses::ToolChoiceAllowed::Mode] Constrains the tools available to the model to a pre-defined set.
        #
        #   @param tools [Array<Hash{Symbol=>Object}>] A list of tool definitions that the model should be allowed to call.
        #
        #   @param type [Symbol, :allowed_tools] Allowed tool configuration type. Always `allowed_tools`.

        # Constrains the tools available to the model to a pre-defined set.
        #
        # `auto` allows the model to pick from among the allowed tools and generate a
        # message.
        #
        # `required` requires the model to call one or more of the allowed tools.
        #
        # @see OpenAI::Models::Responses::ToolChoiceAllowed#mode
        module Mode
          extend OpenAI::Internal::Type::Enum

          AUTO = :auto
          REQUIRED = :required

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end
  end
end
