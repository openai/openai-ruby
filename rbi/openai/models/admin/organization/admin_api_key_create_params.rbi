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

          # The number of seconds until the API key expires. Omit this field for a key that
          # does not expire.
          sig { returns(T.nilable(Integer)) }
          attr_reader :expires_in_seconds

          sig { params(expires_in_seconds: Integer).void }
          attr_writer :expires_in_seconds

          sig do
            params(
              name: String,
              expires_in_seconds: Integer,
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(T.attached_class)
          end
          def self.new(
            name:,
            # The number of seconds until the API key expires. Omit this field for a key that
            # does not expire.
            expires_in_seconds: nil,
            request_options: {}
          )
          end

          sig do
            override.returns(
              {
                name: String,
                expires_in_seconds: Integer,
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
