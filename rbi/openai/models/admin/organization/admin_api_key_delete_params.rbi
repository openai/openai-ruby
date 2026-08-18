# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        class AdminAPIKeyDeleteParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Admin::Organization::AdminAPIKeyDeleteParams,
                OpenAI::Internal::AnyHash
              )
            end

          # The ID of the API key to be deleted.
          sig { returns(String) }
          attr_accessor :key_id

          sig do
            params(
              key_id: String,
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(T.attached_class)
          end
          def self.new(
            # The ID of the API key to be deleted.
            key_id:,
            request_options: {}
          )
          end

          sig do
            override.returns(
              { key_id: String, request_options: OpenAI::RequestOptions }
            )
          end
          def to_hash
          end
        end
      end
    end
  end
end
