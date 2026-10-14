# typed: strong

module OpenAI
  module Models

    module Conversations

      class TextContent < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Conversations::TextContent,
            OpenAI::Internal::AnyHash
          )
        end

        sig { returns(String) }
        attr_accessor :text

        sig { returns(Symbol) }
        attr_accessor :type

        # A text content.
        sig do
          params(

            text: String,

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          text:,

          type: :text
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
