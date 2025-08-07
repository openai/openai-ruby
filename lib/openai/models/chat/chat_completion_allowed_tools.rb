# frozen_string_literal: true

module OpenAI
  module Models
    module Chat
      class ChatCompletionAllowedTools < OpenAI::Internal::Type::BaseModel
        # @!attribute mode
        #   Constrains the tools available to the model to a pre-defined set.
        #
        #   `auto` allows the model to pick from among the allowed tools and generate a
        #   message.
        #
        #   `required` requires the model to call one or more of the allowed tools.
        #
        #   @return [Symbol, OpenAI::Models::Chat::ChatCompletionAllowedTools::Mode]
        required :mode, enum: -> { OpenAI::Chat::ChatCompletionAllowedTools::Mode }

        # @!attribute tools
        #   A list of tool definitions that the model should be allowed to call.
        #
        #   For the Chat Completions API, the list of tool definitions might look like:
        #
        #   ```json
        #   [
        #     { "type": "function", "function": { "name": "get_weather" } },
        #     { "type": "function", "function": { "name": "get_time" } }
        #   ]
        #   ```
        #
        #   @return [Array<Hash{Symbol=>Object}>]
        required :tools,
                 OpenAI::Internal::Type::ArrayOf[OpenAI::Internal::Type::HashOf[OpenAI::Internal::Type::Unknown]]

        # @!method initialize(mode:, tools:)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Chat::ChatCompletionAllowedTools} for more details.
        #
        #   Constrains the tools available to the model to a pre-defined set.
        #
        #   @param mode [Symbol, OpenAI::Models::Chat::ChatCompletionAllowedTools::Mode] Constrains the tools available to the model to a pre-defined set.
        #
        #   @param tools [Array<Hash{Symbol=>Object}>] A list of tool definitions that the model should be allowed to call.

        # Constrains the tools available to the model to a pre-defined set.
        #
        # `auto` allows the model to pick from among the allowed tools and generate a
        # message.
        #
        # `required` requires the model to call one or more of the allowed tools.
        #
        # @see OpenAI::Models::Chat::ChatCompletionAllowedTools#mode
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
