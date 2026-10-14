# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        class UserUpdateParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Admin::Organization::UserUpdateParams,
                OpenAI::Internal::AnyHash
              )
            end

          sig { returns(String) }
          attr_accessor :user_id

          # Developer persona metadata.
          sig { returns(T.nilable(String)) }
          attr_accessor :developer_persona

          # `owner` or `reader`
          sig { returns(T.nilable(String)) }
          attr_accessor :role

          # Role ID to assign to the user.
          sig { returns(T.nilable(String)) }
          attr_accessor :role_id

          # Technical level metadata.
          sig { returns(T.nilable(String)) }
          attr_accessor :technical_level

          sig do
            params(
              user_id: String,
              developer_persona: T.nilable(String),
              role: T.nilable(String),
              role_id: T.nilable(String),
              technical_level: T.nilable(String),
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(T.attached_class)
          end
          def self.new(
            user_id:,
            # Developer persona metadata.
            developer_persona: nil,
            # `owner` or `reader`
            role: nil,
            # Role ID to assign to the user.
            role_id: nil,
            # Technical level metadata.
            technical_level: nil,
            request_options: {}
          )
          end

          sig do
            override.returns(
              {
                user_id: String,
                developer_persona: T.nilable(String),
                role: T.nilable(String),
                role_id: T.nilable(String),
                technical_level: T.nilable(String),
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
