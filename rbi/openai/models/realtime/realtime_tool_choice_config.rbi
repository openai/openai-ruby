# typed: strong

module OpenAI
  module Models
    module Realtime
      # How the model chooses tools. Provide one of the string modes or force a specific
      # function/MCP tool.
      module RealtimeToolChoiceConfig
        extend OpenAI::Internal::Type::Union

        Variants =
          T.type_alias do
            T.any(
              OpenAI::Responses::ToolChoiceOptions::TaggedSymbol,
              OpenAI::Responses::ToolChoiceFunction,
              OpenAI::Responses::ToolChoiceMcp
            )
          end

        sig do
          override.returns(
            T::Array[OpenAI::Realtime::RealtimeToolChoiceConfig::Variants]
          )
        end
        def self.variants
        end
      end
    end
  end
end
