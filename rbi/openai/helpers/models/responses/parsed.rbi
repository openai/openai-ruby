# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseOutputText
        # The parsed contents of the output, if JSON schema is specified.
        sig { returns(T.anything) }
        attr_accessor :parsed
      end

      class ResponseFunctionToolCall
        # The parsed contents of the arguments.
        sig { returns(T.anything) }
        attr_accessor :parsed
      end
    end
  end
end
