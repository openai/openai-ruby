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

          # `owner` or `reader`
          sig do
            returns(
              OpenAI::Admin::Organization::UserUpdateParams::Role::OrSymbol
            )
          end
          attr_accessor :role

          sig do
            params(
              user_id: String,
              role:
                OpenAI::Admin::Organization::UserUpdateParams::Role::OrSymbol,
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(T.attached_class)
          end
          def self.new(
            user_id:,
            # `owner` or `reader`
            role:,
            request_options: {}
          )
          end

          sig do
            override.returns(
              {
                user_id: String,
                role:
                  OpenAI::Admin::Organization::UserUpdateParams::Role::OrSymbol,
                request_options: OpenAI::RequestOptions
              }
            )
          end
          def to_hash
          end

          # `owner` or `reader`
          module Role
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Admin::Organization::UserUpdateParams::Role
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            OWNER =
              T.let(
                :owner,
                OpenAI::Admin::Organization::UserUpdateParams::Role::TaggedSymbol
              )
            READER =
              T.let(
                :reader,
                OpenAI::Admin::Organization::UserUpdateParams::Role::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Admin::Organization::UserUpdateParams::Role::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end
        end
      end
    end
  end
end
