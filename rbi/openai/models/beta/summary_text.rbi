# typed: strong

module OpenAI
  module Models

    module Beta

      class SummaryText < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Beta::SummaryText,
            OpenAI::Internal::AnyHash
          )
        end

        # The reasoning summary text.
        sig { returns(String) }
        attr_accessor :text

        # The content type. Always `summary_text`.
        sig { returns(Symbol) }
        attr_accessor :type

        # A reasoning summary content part.
        sig do
          params(

            text: String,

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The reasoning summary text.
          text:,

          # The content type. Always `summary_text`.

          type: :summary_text
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
