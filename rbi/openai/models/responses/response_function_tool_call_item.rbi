# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseFunctionToolCallItem < OpenAI::Models::Responses::ResponseFunctionToolCall
        OrHash = T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

        # The unique ID of the function tool call.
        sig { returns(String) }
        attr_accessor :id

        # A tool call to run a function. See the
        # [function calling guide](https://platform.openai.com/docs/guides/function-calling)
        # for more information.
        sig { params(id: String).returns(T.attached_class) }
        def self.new(
          # The unique ID of the function tool call.
          id:
        )
        end

        sig { override.returns({ id: String }) }
        def to_hash
        end
      end
    end
  end
end
