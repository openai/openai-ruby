# typed: strong

module OpenAI
  module Models
    module Responses
      # An output message from the model.
      module ResponseOutputItem
        extend OpenAI::Internal::Type::Union

        sig do
          override
            .returns(
              [OpenAI::Models::Responses::ResponseOutputMessage, OpenAI::Models::Responses::ResponseFileSearchToolCall, OpenAI::Models::Responses::ResponseFunctionToolCall, OpenAI::Models::Responses::ResponseFunctionWebSearch, OpenAI::Models::Responses::ResponseComputerToolCall, OpenAI::Models::Responses::ResponseReasoningItem]
            )
        end
        def self.variants
        end
      end
    end
  end
end
