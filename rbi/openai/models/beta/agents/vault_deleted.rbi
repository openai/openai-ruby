# typed: strong

module OpenAI
  module Models

    module Beta

      module Agents

        class VaultDeleted < OpenAI::Internal::Type::BaseModel

          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::Agents::VaultDeleted,
              OpenAI::Internal::AnyHash
            )
          end

          # The ID of the deleted vault.
          sig { returns(String) }
          attr_accessor :id

          # Whether the resource was deleted. Always `true`.
          sig { returns(T::Boolean) }
          attr_accessor :deleted

          # The object type. Always `vault.deleted`.
          sig { returns(Symbol) }
          attr_accessor :object

          # Confirmation that a vault was deleted.
          sig do
            params(

              id: String,

              deleted: T::Boolean,

              object: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The ID of the deleted vault.
            id:,

            # Whether the resource was deleted. Always `true`.
            deleted:,

            # The object type. Always `vault.deleted`.

            object: :"vault.deleted"
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
