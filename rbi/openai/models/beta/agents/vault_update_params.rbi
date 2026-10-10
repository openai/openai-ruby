# typed: strong

module OpenAI
  module Models

    module Beta

      module Agents

        class VaultUpdateParams < OpenAI::Internal::Type::BaseModel

          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::Agents::VaultUpdateParams,
              OpenAI::Internal::AnyHash
            )
          end

          sig { returns(String) }
          attr_accessor :vault_id

          # Replaces all metadata. Omit to leave unchanged, or pass {} to clear it. Up to 16
          # string key-value pairs, with keys up to 64 and values up to 512 characters.
          sig { returns(T.nilable(T::Hash[Symbol, String])) }
          attr_reader :metadata

          sig { params(metadata: T::Hash[Symbol, String]).void }
          attr_writer :metadata

          # A replacement name. Omit to leave unchanged, or pass null to clear it. The name
          # is trimmed before storage. It must contain 1 to 256 UTF-8 bytes after trimming.
          sig { returns(T.nilable(String)) }
          attr_accessor :name

          sig do
            params(

              vault_id: String,

              metadata: T::Hash[Symbol, String],

              name: T.nilable(String),

              request_options: OpenAI::RequestOptions::OrHash
            )
              .returns(T.attached_class)
          end
          def self.new(

            vault_id:,

            # Replaces all metadata. Omit to leave unchanged, or pass {} to clear it. Up to 16
            # string key-value pairs, with keys up to 64 and values up to 512 characters.
            metadata: nil,

            # A replacement name. Omit to leave unchanged, or pass null to clear it. The name
            # is trimmed before storage. It must contain 1 to 256 UTF-8 bytes after trimming.
            name: nil,

            request_options: {}
          )
          end

          sig do
            override.returns(
              {
                vault_id: String,
                metadata: T::Hash[Symbol, String],
                name: T.nilable(String),
                request_options: OpenAI::RequestOptions
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
