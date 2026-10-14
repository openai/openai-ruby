# typed: strong

module OpenAI
  module Models

    module Beta

      module Agents

        class VaultDeleteParams < OpenAI::Internal::Type::BaseModel

          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::Agents::VaultDeleteParams,
              OpenAI::Internal::AnyHash
            )
          end

          sig { returns(String) }
          attr_accessor :vault_id

          sig do
            params(

              vault_id: String,

              request_options: OpenAI::RequestOptions::OrHash
            )
              .returns(T.attached_class)
          end
          def self.new(

            vault_id:,

            request_options: {}
          )
          end

          sig do
            override.returns(
              {vault_id: String, request_options: OpenAI::RequestOptions}
            )
          end
          def to_hash
          end

        end

      end

    end

  end
end
