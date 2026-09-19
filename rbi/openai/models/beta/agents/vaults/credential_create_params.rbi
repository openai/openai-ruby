# typed: strong

module OpenAI
  module Models

    module Beta

      module Agents

        module Vaults

          class CredentialCreateParams < OpenAI::Internal::Type::BaseModel

            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            OrHash = T.type_alias do
              T.any(
                OpenAI::Beta::Agents::Vaults::CredentialCreateParams,
                OpenAI::Internal::AnyHash
              )
            end

            sig { returns(String) }
            attr_accessor :vault_id

            # The authentication method and write-only secret values to store.
            sig {
              returns(
                T.any(
                  OpenAI::Beta::Agents::Vaults::CredentialAuthCreateParam::McpOauth,
                  OpenAI::Beta::Agents::Vaults::CredentialAuthCreateParam::StaticBearer,
                  OpenAI::Beta::Agents::Vaults::CredentialAuthCreateParam::EnvironmentVariable
                )
              )
            }
            attr_accessor :auth

            # The name is trimmed before storage. It must contain 1 to 256 UTF-8 bytes after
            # trimming.
            sig { returns(String) }
            attr_accessor :name

            sig do
              params(

                vault_id: String,

                auth: T.any(
                  OpenAI::Beta::Agents::Vaults::CredentialAuthCreateParam::McpOauth::OrHash,
                  OpenAI::Beta::Agents::Vaults::CredentialAuthCreateParam::StaticBearer::OrHash,
                  OpenAI::Beta::Agents::Vaults::CredentialAuthCreateParam::EnvironmentVariable::OrHash
                ),

                name: String,

                request_options: OpenAI::RequestOptions::OrHash
              )
                .returns(T.attached_class)
            end
            def self.new(

              vault_id:,

              # The authentication method and write-only secret values to store.
              auth:,

              # The name is trimmed before storage. It must contain 1 to 256 UTF-8 bytes after
              # trimming.
              name:,

              request_options: {}
            )
            end

            sig do
              override.returns(
                {
                  vault_id: String,
                  auth: T.any(
                    OpenAI::Beta::Agents::Vaults::CredentialAuthCreateParam::McpOauth,
                    OpenAI::Beta::Agents::Vaults::CredentialAuthCreateParam::StaticBearer,
                    OpenAI::Beta::Agents::Vaults::CredentialAuthCreateParam::EnvironmentVariable
                  ),
                  name: String,
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
