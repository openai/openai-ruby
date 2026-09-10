# typed: strong

module OpenAI
  module Models

    module Beta

      module Agents

        module Vaults

          class CredentialDeleted < OpenAI::Internal::Type::BaseModel

            OrHash = T.type_alias do
              T.any(
                OpenAI::Beta::Agents::Vaults::CredentialDeleted,
                OpenAI::Internal::AnyHash
              )
            end

            # The ID of the deleted credential.
            sig { returns(String) }
            attr_accessor :id

            # Whether the resource was deleted. Always `true`.
            sig { returns(T::Boolean) }
            attr_accessor :deleted

            # The object type. Always `vault.credential.deleted`.
            sig { returns(Symbol) }
            attr_accessor :object

            # Confirmation that a vault credential was deleted.
            sig do
              params(

                id: String,

                deleted: T::Boolean,

                object: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(

              # The ID of the deleted credential.
              id:,

              # Whether the resource was deleted. Always `true`.
              deleted:,

              # The object type. Always `vault.credential.deleted`.

              object: :"vault.credential.deleted"
            )
            end

            sig do
              override.returns(
                {id: String, deleted: T::Boolean, object: Symbol}
              )
            end
            def to_hash
            end

          end

        end

      end

    end

  end
end
