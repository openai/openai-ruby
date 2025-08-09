# typed: strong

module OpenAI
  module Helpers
    module StructuredOutput
      class ArrayOf < OpenAI::Internal::Type::ArrayOf
        include OpenAI::Helpers::StructuredOutput::JsonSchemaConverter

        Elem = type_member(:out)
      end
    end
  end
end
