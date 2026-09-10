# typed: strong

module OpenAI
  module Models

    module Beta

      # A plaintext or encrypted content part exchanged between agents.
      module AgentContent
        extend OpenAI::Internal::Type::Union

        Variants = T.type_alias do
          T.any(
            OpenAI::Beta::OutputText,
            OpenAI::Beta::AgentContent::EncryptedContent
          )
        end

        class EncryptedContent < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::AgentContent::EncryptedContent,
              OpenAI::Internal::AnyHash
            )
          end

          # The encrypted content payload.
          sig { returns(String) }
          attr_accessor :encrypted_content

          # The content type. Always `encrypted_content`.
          sig { returns(Symbol) }
          attr_accessor :type

          # Encrypted content exchanged between agents.
          sig do
            params(

              encrypted_content: String,

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The encrypted content payload.
            encrypted_content:,

            # The content type. Always `encrypted_content`.

            type: :encrypted_content
          )
          end

          sig do
            override.returns(
              {encrypted_content: String, type: Symbol}
            )
          end
          def to_hash
          end

        end

        sig { override.returns(T::Array[OpenAI::Beta::AgentContent::Variants]) }
        def self.variants
        end

      end

    end

  end
end
