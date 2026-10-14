# typed: strong

module OpenAI
  module Models
    module Responses
      class ToolChoiceAllowed < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Responses::ToolChoiceAllowed,
              OpenAI::Internal::AnyHash
            )
          end

        # Constrains the tools available to the model to a pre-defined set.
        #
        # `auto` allows the model to pick from among the allowed tools and generate a
        # message.
        #
        # `required` requires the model to call one or more of the allowed tools.
        sig { returns(OpenAI::Responses::ToolChoiceAllowed::Mode::OrSymbol) }
        attr_accessor :mode

        # A list of tool definitions that the model should be allowed to call.
        #
        # For the Responses API, the list of tool definitions might look like:
        #
        # ```json
        # [
        #   { "type": "function", "name": "get_weather" },
        #   { "type": "mcp", "server_label": "deepwiki" },
        #   { "type": "image_generation" }
        # ]
        # ```
        sig { returns(T::Array[T::Hash[Symbol, T.anything]]) }
        attr_accessor :tools

        # Allowed tool configuration type. Always `allowed_tools`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Constrains the tools available to the model to a pre-defined set.
        sig do
          params(
            mode: OpenAI::Responses::ToolChoiceAllowed::Mode::OrSymbol,
            tools: T::Array[T::Hash[Symbol, T.anything]],
            type: Symbol
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
          # For the Responses API, the list of tool definitions might look like:
          #
          # ```json
          # [
          #   { "type": "function", "name": "get_weather" },
          #   { "type": "mcp", "server_label": "deepwiki" },
          #   { "type": "image_generation" }
          # ]
          # ```
          tools:,
          # Allowed tool configuration type. Always `allowed_tools`.
          type: :allowed_tools
        )
        end

        sig do
          override.returns(
            {
              mode: OpenAI::Responses::ToolChoiceAllowed::Mode::OrSymbol,
              tools: T::Array[T::Hash[Symbol, T.anything]],
              type: Symbol
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
              T.all(Symbol, OpenAI::Responses::ToolChoiceAllowed::Mode)
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          AUTO =
            T.let(
              :auto,
              OpenAI::Responses::ToolChoiceAllowed::Mode::TaggedSymbol
            )
          REQUIRED =
            T.let(
              :required,
              OpenAI::Responses::ToolChoiceAllowed::Mode::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[OpenAI::Responses::ToolChoiceAllowed::Mode::TaggedSymbol]
            )
          end
          def self.values
          end
        end
      end
    end
  end
end
