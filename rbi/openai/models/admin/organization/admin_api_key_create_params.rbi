# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        class AdminAPIKeyCreateParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Admin::Organization::AdminAPIKeyCreateParams,
                OpenAI::Internal::AnyHash
              )
            end

          sig { returns(String) }
          attr_accessor :name

          sig do
            params(
              name: String,
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(T.attached_class)
          end
          def self.new(name:, request_options: {})
          end

          sig do
            override.returns(
              { name: String, request_options: OpenAI::RequestOptions }
            )
          end
          def to_hash
          end
        end
      end
    end
  end
end
