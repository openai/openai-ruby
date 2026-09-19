# typed: strong

module OpenAI
  module Models

    module Admin

      module Organization

        class AwsExternalStorageProvider < OpenAI::Internal::Type::BaseModel

          OrHash = T.type_alias do
            T.any(
              OpenAI::Admin::Organization::AwsExternalStorageProvider,
              OpenAI::Internal::AnyHash
            )
          end

          sig { returns(String) }
          attr_accessor :account_id

          sig { returns(String) }
          attr_accessor :bucket

          sig { returns(String) }
          attr_accessor :external_id

          sig { returns(String) }
          attr_accessor :region

          sig { returns(String) }
          attr_accessor :role_arn

          sig { returns(Symbol) }
          attr_accessor :type

          sig do
            params(

              account_id: String,

              bucket: String,

              external_id: String,

              region: String,

              role_arn: String,

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            account_id:,

            bucket:,

            external_id:,

            region:,

            role_arn:,

            type: :aws
          )
          end

          sig do
            override.returns(
              {account_id: String, bucket: String, external_id: String, region: String, role_arn: String, type: Symbol}
            )
          end
          def to_hash
          end

        end

      end

    end

  end
end
