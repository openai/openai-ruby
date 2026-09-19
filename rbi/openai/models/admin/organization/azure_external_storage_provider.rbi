# typed: strong

module OpenAI
  module Models

    module Admin

      module Organization

        class AzureExternalStorageProvider < OpenAI::Internal::Type::BaseModel

          OrHash = T.type_alias do
            T.any(
              OpenAI::Admin::Organization::AzureExternalStorageProvider,
              OpenAI::Internal::AnyHash
            )
          end

          sig { returns(String) }
          attr_accessor :account_name

          sig { returns(String) }
          attr_accessor :container

          sig { returns(String) }
          attr_accessor :region

          sig { returns(String) }
          attr_accessor :resource_group

          sig { returns(String) }
          attr_accessor :subscription_id

          sig { returns(String) }
          attr_accessor :tenant_id

          sig { returns(Symbol) }
          attr_accessor :type

          sig do
            params(

              account_name: String,

              container: String,

              region: String,

              resource_group: String,

              subscription_id: String,

              tenant_id: String,

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            account_name:,

            container:,

            region:,

            resource_group:,

            subscription_id:,

            tenant_id:,

            type: :azure
          )
          end

          sig do
            override.returns(
              {
                account_name: String,
                container: String,
                region: String,
                resource_group: String,
                subscription_id: String,
                tenant_id: String,
                type: Symbol
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
