# typed: strong

module OpenAI
  module Helpers
    module StructuredOutput
      # Represents a response from OpenAI's API where the model's output has been structured according to a schema predefined by the user.
      #
      # This class is specifically used when making requests with the `response_format` parameter set to use structured output (e.g., JSON).
      #
      # See {examples/structured_outputs_chat_completions.rb} for a complete example of use
      class BaseModel < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Helpers::StructuredOutput::JsonSchemaConverter

        class << self
          sig { returns(T.noreturn) }
          def optional
          end
        end
      end
    end
  end
end
