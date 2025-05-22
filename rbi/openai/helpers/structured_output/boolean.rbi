# typed: strong

module OpenAI
  module Helpers
    module StructuredOutput
      class Boolean < OpenAI::Internal::Type::Boolean
        extend OpenAI::Helpers::StructuredOutput::JsonSchemaConverter
      end
    end
  end
end
