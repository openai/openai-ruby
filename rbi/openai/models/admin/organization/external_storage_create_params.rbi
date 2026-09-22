# typed: strong

module OpenAI
  module Models

    module Admin

      module Organization

        class ExternalStorageCreateParams < OpenAI::Internal::Type::BaseModel

          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          OrHash = T.type_alias do
            T.any(
              OpenAI::Admin::Organization::ExternalStorageCreateParams,
              OpenAI::Internal::AnyHash
            )
          end

          sig { returns(String) }
          attr_accessor :project_id

          sig {
            returns(
              T.any(
                OpenAI::Admin::Organization::ExternalStorageCreateParams::Provider::Aws,
                OpenAI::Admin::Organization::ExternalStorageCreateParams::Provider::Azure,
                OpenAI::Admin::Organization::ExternalStorageCreateParams::Provider::Gcp
              )
            )
          }
          attr_accessor :provider

          sig do
            params(

              project_id: String,

              provider: T.any(
                OpenAI::Admin::Organization::ExternalStorageCreateParams::Provider::Aws::OrHash,
                OpenAI::Admin::Organization::ExternalStorageCreateParams::Provider::Azure::OrHash,
                OpenAI::Admin::Organization::ExternalStorageCreateParams::Provider::Gcp::OrHash
              ),

              request_options: OpenAI::RequestOptions::OrHash
            )
              .returns(T.attached_class)
          end
          def self.new(

            project_id:,

            provider:,

            request_options: {}
          )
          end

          sig do
            override.returns(
              {
                project_id: String,
                provider: T.any(
                  OpenAI::Admin::Organization::ExternalStorageCreateParams::Provider::Aws,
                  OpenAI::Admin::Organization::ExternalStorageCreateParams::Provider::Azure,
                  OpenAI::Admin::Organization::ExternalStorageCreateParams::Provider::Gcp
                ),
                request_options: OpenAI::RequestOptions
              }
            )
          end
          def to_hash
          end

          module Provider
            extend OpenAI::Internal::Type::Union

            Variants = T.type_alias {
              T.any(
                OpenAI::Admin::Organization::ExternalStorageCreateParams::Provider::Aws,
                OpenAI::Admin::Organization::ExternalStorageCreateParams::Provider::Azure,
                OpenAI::Admin::Organization::ExternalStorageCreateParams::Provider::Gcp
              )
            }

            class Aws < OpenAI::Internal::Type::BaseModel
              OrHash = T.type_alias do
                T.any(
                  OpenAI::Admin::Organization::ExternalStorageCreateParams::Provider::Aws,
                  OpenAI::Internal::AnyHash
                )
              end

              sig { returns(String) }
              attr_accessor :bucket

              sig { returns(String) }
              attr_accessor :role_arn

              sig { returns(Symbol) }
              attr_accessor :type

              sig do
                params(

                  bucket: String,

                  role_arn: String,

                  type: Symbol
                )
                  .returns(T.attached_class)
              end
              def self.new(

                bucket:,

                role_arn:,

                type: :aws
              )
              end

              sig do
                override.returns(
                  {bucket: String, role_arn: String, type: Symbol}
                )
              end
              def to_hash
              end

            end

            class Azure < OpenAI::Internal::Type::BaseModel
              OrHash = T.type_alias do
                T.any(
                  OpenAI::Admin::Organization::ExternalStorageCreateParams::Provider::Azure,
                  OpenAI::Internal::AnyHash
                )
              end

              sig { returns(String) }
              attr_accessor :account_name

              sig { returns(String) }
              attr_accessor :container

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

            class Gcp < OpenAI::Internal::Type::BaseModel
              OrHash = T.type_alias do
                T.any(
                  OpenAI::Admin::Organization::ExternalStorageCreateParams::Provider::Gcp,
                  OpenAI::Internal::AnyHash
                )
              end

              sig { returns(String) }
              attr_accessor :bucket

              sig { returns(Symbol) }
              attr_accessor :type

              sig { returns(String) }
              attr_accessor :workload_identity_pool_id

              sig { returns(String) }
              attr_accessor :workload_identity_project_number

              sig { returns(String) }
              attr_accessor :workload_identity_provider_id

              sig do
                params(

                  bucket: String,

                  workload_identity_pool_id: String,

                  workload_identity_project_number: String,

                  workload_identity_provider_id: String,

                  type: Symbol
                )
                  .returns(T.attached_class)
              end
              def self.new(

                bucket:,

                workload_identity_pool_id:,

                workload_identity_project_number:,

                workload_identity_provider_id:,

                type: :gcp
              )
              end

              sig do
                override.returns(
                  {
                    bucket: String,
                    type: Symbol,
                    workload_identity_pool_id: String,
                    workload_identity_project_number: String,
                    workload_identity_provider_id: String
                  }
                )
              end
              def to_hash
              end

            end

            sig {
              override.returns(T::Array[OpenAI::Admin::Organization::ExternalStorageCreateParams::Provider::Variants])
            }
            def self.variants
            end

          end

        end

      end

    end

  end
end
