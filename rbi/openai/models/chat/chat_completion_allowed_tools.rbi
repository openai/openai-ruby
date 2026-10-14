# typed: strong

module OpenAI
  module Models
    module Chat
      class ChatCompletionAllowedTools < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Chat::ChatCompletionAllowedTools,
              OpenAI::Internal::AnyHash
            )
          end

        # Constrains the tools available to the model to a pre-defined set.
        #
        # `auto` allows the model to pick from among the allowed tools and generate a
        # message.
        #
        # `required` requires the model to call one or more of the allowed tools.
        sig do
          returns(OpenAI::Chat::ChatCompletionAllowedTools::Mode::OrSymbol)
        end
        attr_accessor :mode

        # A list of tool definitions that the model should be allowed to call.
        #
        # For the Chat Completions API, the list of tool definitions might look like:
        #
        # ```json
        # [
        #   { "type": "function", "function": { "name": "get_weather" } },
        #   { "type": "function", "function": { "name": "get_time" } }
        # ]
        # ```
        sig { returns(T::Array[T::Hash[Symbol, T.anything]]) }
        attr_accessor :tools

        # Constrains the tools available to the model to a pre-defined set.
        sig do
          params(
            mode: OpenAI::Chat::ChatCompletionAllowedTools::Mode::OrSymbol,
            tools: T::Array[T::Hash[Symbol, T.anything]]
          ).returns(T.attached_class)
        end
        def self.new(
          # Constrains the tools available to the model to a pre-defined set.
          #
          # `auto` allows the model to pick from among the allowed tools and generate a
          # message.
          #
          # `required` requires the model to call one or more of the allowed tools.
          mode:,
          # A list of tool definitions that the model should be allowed to call.
          #
          # For the Chat Completions API, the list of tool definitions might look like:
          #
          # ```json
          # [
          #   { "type": "function", "function": { "name": "get_weather" } },
          #   { "type": "function", "function": { "name": "get_time" } }
          # ]
          # ```
          tools:
        )
        end

        sig do
          override.returns(
            {
              mode: OpenAI::Chat::ChatCompletionAllowedTools::Mode::OrSymbol,
              tools: T::Array[T::Hash[Symbol, T.anything]]
            }
          )
        end
        def to_hash
        end

        # Constrains the tools available to the model to a pre-defined set.
        #
        # `auto` allows the model to pick from among the allowed tools and generate a
        # message.
        #
        # `required` requires the model to call one or more of the allowed tools.
        module Mode
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(Symbol, OpenAI::Chat::ChatCompletionAllowedTools::Mode)
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          AUTO =
            T.let(
              :auto,
              OpenAI::Chat::ChatCompletionAllowedTools::Mode::TaggedSymbol
            )
          REQUIRED =
            T.let(
              :required,
              OpenAI::Chat::ChatCompletionAllowedTools::Mode::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Chat::ChatCompletionAllowedTools::Mode::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end
      end
    end
  end
end
