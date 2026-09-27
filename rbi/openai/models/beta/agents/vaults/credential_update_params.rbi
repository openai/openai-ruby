# typed: strong

module OpenAI
  module Models

    module Beta

      module Agents

        module Vaults

          class CredentialUpdateParams < OpenAI::Internal::Type::BaseModel

            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            OrHash = T.type_alias do
              T.any(
                OpenAI::Beta::Agents::Vaults::CredentialUpdateParams,
                OpenAI::Internal::AnyHash
              )
            end

            sig { returns(String) }
            attr_accessor :vault_id

            sig { returns(String) }
            attr_accessor :credential_id

            # Replacement values for the credential's existing authentication method.
            sig {
              returns(
                T.nilable(
                  T.any(
                    OpenAI::Beta::Agents::Vaults::CredentialAuthRotateParam::McpOauth,
                    OpenAI::Beta::Agents::Vaults::CredentialAuthRotateParam::StaticBearer,
                    OpenAI::Beta::Agents::Vaults::CredentialAuthRotateParam::EnvironmentVariable
                  )
                )
              )
            }
            attr_reader :auth

            sig {
              params(
                auth: T.any(
                  OpenAI::Beta::Agents::Vaults::CredentialAuthRotateParam::McpOauth::OrHash,
                  OpenAI::Beta::Agents::Vaults::CredentialAuthRotateParam::StaticBearer::OrHash,
                  OpenAI::Beta::Agents::Vaults::CredentialAuthRotateParam::EnvironmentVariable::OrHash
                )
              )
                .void
            }
            attr_writer :auth

            # Replaces all metadata. Omit to preserve it, or pass {} to clear it. Up to 16
            # string key-value pairs, with keys up to 64 and values up to 512 characters.
            sig { returns(T.nilable(T::Hash[Symbol, String])) }
            attr_reader :metadata

            sig { params(metadata: T::Hash[Symbol, String]).void }
            attr_writer :metadata

            sig do
              params(

                vault_id: String,

                credential_id: String,

                auth: T.any(
                  OpenAI::Beta::Agents::Vaults::CredentialAuthRotateParam::McpOauth::OrHash,
                  OpenAI::Beta::Agents::Vaults::CredentialAuthRotateParam::StaticBearer::OrHash,
                  OpenAI::Beta::Agents::Vaults::CredentialAuthRotateParam::EnvironmentVariable::OrHash
                ),

                metadata: T::Hash[Symbol, String],

                request_options: OpenAI::RequestOptions::OrHash
              )
                .returns(T.attached_class)
            end
            def self.new(

              vault_id:,

              credential_id:,

              # Replacement values for the credential's existing authentication method.
              auth: nil,

              # Replaces all metadata. Omit to preserve it, or pass {} to clear it. Up to 16
              # string key-value pairs, with keys up to 64 and values up to 512 characters.
              metadata: nil,

              request_options: {}
            )
            end

            sig do
              override.returns(
                {
                  vault_id: String,
                  credential_id: String,
                  auth: T.any(
                    OpenAI::Beta::Agents::Vaults::CredentialAuthRotateParam::McpOauth,
                    OpenAI::Beta::Agents::Vaults::CredentialAuthRotateParam::StaticBearer,
                    OpenAI::Beta::Agents::Vaults::CredentialAuthRotateParam::EnvironmentVariable
                  ),
                  metadata: T::Hash[Symbol, String],
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
end
