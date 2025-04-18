# typed: strong

module OpenAI
  module Models
    module Beta
      class AssistantToolChoice < OpenAI::Internal::Type::BaseModel
        # The type of the tool. If type is `function`, the function name must be set
        sig { returns(OpenAI::Models::Beta::AssistantToolChoice::Type::OrSymbol) }
        attr_accessor :type

        sig { returns(T.nilable(OpenAI::Models::Beta::AssistantToolChoiceFunction)) }
        attr_reader :function

        sig { params(function: T.any(OpenAI::Models::Beta::AssistantToolChoiceFunction, OpenAI::Internal::AnyHash)).void }
        attr_writer :function

        # Specifies a tool the model should use. Use to force the model to call a specific
        # tool.
        sig do
          params(
            type: OpenAI::Models::Beta::AssistantToolChoice::Type::OrSymbol,
            function: T.any(OpenAI::Models::Beta::AssistantToolChoiceFunction, OpenAI::Internal::AnyHash)
          )
            .returns(T.attached_class)
        end
        def self.new(type:, function: nil); end

        sig do
          override
            .returns(
              {
                type: OpenAI::Models::Beta::AssistantToolChoice::Type::OrSymbol,
                function: OpenAI::Models::Beta::AssistantToolChoiceFunction
              }
            )
        end
        def to_hash; end

        # The type of the tool. If type is `function`, the function name must be set
        module Type
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::Beta::AssistantToolChoice::Type) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          FUNCTION = T.let(:function, OpenAI::Models::Beta::AssistantToolChoice::Type::TaggedSymbol)
          CODE_INTERPRETER =
            T.let(:code_interpreter, OpenAI::Models::Beta::AssistantToolChoice::Type::TaggedSymbol)
          FILE_SEARCH = T.let(:file_search, OpenAI::Models::Beta::AssistantToolChoice::Type::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Models::Beta::AssistantToolChoice::Type::TaggedSymbol]) }
          def self.values; end
        end
      end
    end
  end
end
