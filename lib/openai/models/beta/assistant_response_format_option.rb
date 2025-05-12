# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      # Specifies the format that the model must output. Compatible with
      # [GPT-4o](https://platform.openai.com/docs/models#gpt-4o),
      # [GPT-4 Turbo](https://platform.openai.com/docs/models#gpt-4-turbo-and-gpt-4),
      # and all GPT-3.5 Turbo models since `gpt-3.5-turbo-1106`.
      #
      # Setting to `{ "type": "json_schema", "json_schema": {...} }` enables Structured
      # Outputs which ensures the model will match your supplied JSON schema. Learn more
      # in the
      # [Structured Outputs guide](https://platform.openai.com/docs/guides/structured-outputs).
      #
      # Setting to `{ "type": "json_object" }` enables JSON mode, which ensures the
      # message the model generates is valid JSON.
      #
      # **Important:** when using JSON mode, you **must** also instruct the model to
      # produce JSON yourself via a system or user message. Without this, the model may
      # generate an unending stream of whitespace until the generation reaches the token
      # limit, resulting in a long-running and seemingly "stuck" request. Also note that
      # the message content may be partially cut off if `finish_reason="length"`, which
      # indicates the generation exceeded `max_tokens` or the conversation exceeded the
      # max context length.
      module AssistantResponseFormatOption
        extend OpenAI::Internal::Type::Union

        # `auto` is the default value
        variant const: :auto

        # Default response format. Used to generate text responses.
        variant -> { OpenAI::ResponseFormatText }

        # JSON object response format. An older method of generating JSON responses.
        # Using `json_schema` is recommended for models that support it. Note that the
        # model will not generate JSON without a system or user message instructing it
        # to do so.
        variant -> { OpenAI::ResponseFormatJSONObject }

        # JSON Schema response format. Used to generate structured JSON responses.
        # Learn more about [Structured Outputs](https://platform.openai.com/docs/guides/structured-outputs).
        variant -> { OpenAI::ResponseFormatJSONSchema }

        # @!method self.variants
        #   @return [Array(Symbol, :auto, OpenAI::ResponseFormatText, OpenAI::ResponseFormatJSONObject, OpenAI::ResponseFormatJSONSchema)]

        define_sorbet_constant!(:Variants) do
          T.type_alias do
            T.any(
              Symbol,
              OpenAI::ResponseFormatText,
              OpenAI::ResponseFormatJSONObject,
              OpenAI::ResponseFormatJSONSchema
            )
          end
        end
      end
    end
  end
end
