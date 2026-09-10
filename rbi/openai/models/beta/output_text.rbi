# typed: strong

module OpenAI
  module Models

    module Beta

      class OutputText < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Beta::OutputText,
            OpenAI::Internal::AnyHash
          )
        end

        # The text produced by the agent.
        sig { returns(String) }
        attr_accessor :text

        # The content type. Always `output_text`.
        sig { returns(Symbol) }
        attr_accessor :type

        # A text content part produced by the agent.
        sig do
          params(

            text: String,

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The text produced by the agent.
          text:,

          # The content type. Always `output_text`.

          type: :output_text
        )
        end

        sig do
          override.returns(
            {text: String, type: Symbol}
          )
        end
        def to_hash
        end

      end

    end

  end
end
