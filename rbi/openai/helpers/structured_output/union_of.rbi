# typed: strong

module OpenAI
  module Helpers
    module StructuredOutput
      # @example
      #   example = OpenAI::UnionOf[Float, OpenAI::ArrayOf[Integer]]
      class UnionOf
        include OpenAI::Internal::Type::Union
        include OpenAI::Helpers::StructuredOutput::JsonSchemaConverter

        sig do
          params(
            variants:
              OpenAI::Helpers::StructuredOutput::JsonSchemaConverter::Input
          ).returns(T.attached_class)
        end
        def self.[](*variants)
        end
      end
    end
  end
end
