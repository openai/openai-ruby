# typed: strong

module OpenAI
  module Models
    module Beta
      class AssistantToolChoice < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(OpenAI::Beta::AssistantToolChoice, OpenAI::Internal::AnyHash)
          end

        # The type of the tool. If type is `function`, the function name must be set
        sig { returns(OpenAI::Beta::AssistantToolChoice::Type::OrSymbol) }
        attr_accessor :type

        sig { returns(T.nilable(OpenAI::Beta::AssistantToolChoiceFunction)) }
        attr_reader :function

        sig do
          params(
            function: OpenAI::Beta::AssistantToolChoiceFunction::OrHash
          ).void
        end
        attr_writer :function

        # Specifies a tool the model should use. Use to force the model to call a specific
        # tool.
        sig do
          params(
            type: OpenAI::Beta::AssistantToolChoice::Type::OrSymbol,
            function: OpenAI::Beta::AssistantToolChoiceFunction::OrHash
          ).returns(T.attached_class)
        end
        def self.new(
          # The type of the tool. If type is `function`, the function name must be set
          type:,
          function: nil
        )
        end

        sig do
          override.returns(
            {
              type: OpenAI::Beta::AssistantToolChoice::Type::OrSymbol,
              function: OpenAI::Beta::AssistantToolChoiceFunction
            }
          )
        end
        def to_hash
        end

        # The type of the tool. If type is `function`, the function name must be set
        module Type
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(Symbol, OpenAI::Beta::AssistantToolChoice::Type)
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          FUNCTION =
            T.let(
              :function,
              OpenAI::Beta::AssistantToolChoice::Type::TaggedSymbol
            )
          CODE_INTERPRETER =
            T.let(
              :code_interpreter,
              OpenAI::Beta::AssistantToolChoice::Type::TaggedSymbol
            )
          FILE_SEARCH =
            T.let(
              :file_search,
              OpenAI::Beta::AssistantToolChoice::Type::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[OpenAI::Beta::AssistantToolChoice::Type::TaggedSymbol]
            )
          end
          def self.values
          end
        end
      end
    end
  end
end
