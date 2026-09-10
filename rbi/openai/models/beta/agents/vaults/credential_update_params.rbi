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
                T.any(
                  OpenAI::Beta::Agents::Vaults::CredentialAuthRotateParam::McpOauth,
                  OpenAI::Beta::Agents::Vaults::CredentialAuthRotateParam::StaticBearer
                )
              )
            }
            attr_accessor :auth

            sig do
              params(

                vault_id: String,

                credential_id: String,

                auth: T.any(
                  OpenAI::Beta::Agents::Vaults::CredentialAuthRotateParam::McpOauth::OrHash,
                  OpenAI::Beta::Agents::Vaults::CredentialAuthRotateParam::StaticBearer::OrHash
                ),

                request_options: OpenAI::RequestOptions::OrHash
              )
                .returns(T.attached_class)
            end
            def self.new(

              vault_id:,

              credential_id:,

              # Replacement values for the credential's existing authentication method.
              auth:,

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
                    OpenAI::Beta::Agents::Vaults::CredentialAuthRotateParam::StaticBearer
                  ),
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
