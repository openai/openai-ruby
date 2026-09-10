# typed: strong

module OpenAI
  module Models

    module Beta

      module Agents

        class Vault < OpenAI::Internal::Type::BaseModel

          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::Agents::Vault,
              OpenAI::Internal::AnyHash
            )
          end

          # The ID of the vault.
          sig { returns(String) }
          attr_accessor :id

          # The Unix timestamp, in seconds, when the vault was created.
          sig { returns(Integer) }
          attr_accessor :created_at

          # Key-value pairs associated with the vault, such as an application or team
          # identifier.
          sig { returns(T::Hash[Symbol, String]) }
          attr_accessor :metadata

          # The human-readable name of the vault, if set.
          sig { returns(T.nilable(String)) }
          attr_accessor :name

          # The object type. Always `vault`.
          sig { returns(Symbol) }
          attr_accessor :object

          # A collection of credentials that agent tools can use to authenticate to MCP
          # servers.
          sig do
            params(

              id: String,

              created_at: Integer,

              metadata: T::Hash[Symbol, String],

              name: T.nilable(String),

              object: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The ID of the vault.
            id:,

            # The Unix timestamp, in seconds, when the vault was created.
            created_at:,

            # Key-value pairs associated with the vault, such as an application or team
            # identifier.
            metadata:,

            # The human-readable name of the vault, if set.
            name:,

            # The object type. Always `vault`.

            object: :vault
          )
          end

          sig do
            override.returns(
              {
                id: String,
                created_at: Integer,
                metadata: T::Hash[Symbol, String],
                name: T.nilable(String),
                object: Symbol
              }
            )
          end
          def to_hash
          end

        end

      end

    end

  end
end
