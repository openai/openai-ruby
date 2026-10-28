# typed: strong

module OpenAI
  module Models

    module Admin

      module Organization

        class ExternalKeyCreateParams < OpenAI::Internal::Type::BaseModel

          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          OrHash = T.type_alias do
            T.any(
              OpenAI::Admin::Organization::ExternalKeyCreateParams,
              OpenAI::Internal::AnyHash
            )
          end

          sig {
            returns(
              T.any(
                OpenAI::Admin::Organization::ExternalKeyCreateParams::Body::Aws,
                OpenAI::Admin::Organization::ExternalKeyCreateParams::Body::Gcp,
                OpenAI::Admin::Organization::ExternalKeyCreateParams::Body::Azure
              )
            )
          }
          attr_accessor :body

          sig do
            params(

              body: T.any(
                OpenAI::Admin::Organization::ExternalKeyCreateParams::Body::Aws::OrHash,
                OpenAI::Admin::Organization::ExternalKeyCreateParams::Body::Gcp::OrHash,
                OpenAI::Admin::Organization::ExternalKeyCreateParams::Body::Azure::OrHash
              ),

              request_options: OpenAI::RequestOptions::OrHash
            )
              .returns(T.attached_class)
          end
          def self.new(

            body:,

            request_options: {}
          )
          end

          sig do
            override.returns(
              {
                body: T.any(
                  OpenAI::Admin::Organization::ExternalKeyCreateParams::Body::Aws,
                  OpenAI::Admin::Organization::ExternalKeyCreateParams::Body::Gcp,
                  OpenAI::Admin::Organization::ExternalKeyCreateParams::Body::Azure
                ),
                request_options: OpenAI::RequestOptions
              }
            )
          end
          def to_hash
          end

          module Body
            extend OpenAI::Internal::Type::Union

            Variants = T.type_alias {
              T.any(
                OpenAI::Admin::Organization::ExternalKeyCreateParams::Body::Aws,
                OpenAI::Admin::Organization::ExternalKeyCreateParams::Body::Gcp,
                OpenAI::Admin::Organization::ExternalKeyCreateParams::Body::Azure
              )
            }

            class Aws < OpenAI::Internal::Type::BaseModel
              OrHash = T.type_alias do
                T.any(
                  OpenAI::Admin::Organization::ExternalKeyCreateParams::Body::Aws,
                  OpenAI::Internal::AnyHash
                )
              end

              # The ExternalID that OpenAI will pass in the AssumeRole call for the customer's
              # AWS account. This must be the OpenAI organization ID or an API project ID that
              # belongs to the organization.
              sig { returns(String) }
              attr_accessor :external_id

              # The Key Management System ARN for the master key you manage
              sig { returns(String) }
              attr_accessor :kms_arn

              # A friendly name to identify this config
              sig { returns(String) }
              attr_accessor :name

              # The Role ARN that OpenAI will assume to call your KMS
              sig { returns(String) }
              attr_accessor :role_arn

              sig { returns(Symbol) }
              attr_accessor :type

              sig {
                returns(T.nilable(OpenAI::Admin::Organization::ExternalKeyCreateParams::Body::Aws::Purpose::OrSymbol))
              }
              attr_reader :purpose

              sig {
                params(purpose: OpenAI::Admin::Organization::ExternalKeyCreateParams::Body::Aws::Purpose::OrSymbol).void
              }
              attr_writer :purpose

              sig do
                params(

                  external_id: String,

                  kms_arn: String,

                  name: String,

                  role_arn: String,

                  purpose: OpenAI::Admin::Organization::ExternalKeyCreateParams::Body::Aws::Purpose::OrSymbol,

                  type: Symbol
                )
                  .returns(T.attached_class)
              end
              def self.new(

                # The ExternalID that OpenAI will pass in the AssumeRole call for the customer's
                # AWS account. This must be the OpenAI organization ID or an API project ID that
                # belongs to the organization.
                external_id:,

                # The Key Management System ARN for the master key you manage
                kms_arn:,

                # A friendly name to identify this config
                name:,

                # The Role ARN that OpenAI will assume to call your KMS
                role_arn:,

                purpose: nil,

                type: :aws
              )
              end

              sig do
                override.returns(
                  {
                    external_id: String,
                    kms_arn: String,
                    name: String,
                    role_arn: String,
                    type: Symbol,
                    purpose: OpenAI::Admin::Organization::ExternalKeyCreateParams::Body::Aws::Purpose::OrSymbol
                  }
                )
              end
              def to_hash
              end

              module Purpose
                extend OpenAI::Internal::Type::Enum

                TaggedSymbol = T.type_alias {
                  T.all(Symbol, OpenAI::Admin::Organization::ExternalKeyCreateParams::Body::Aws::Purpose)
                }
                OrSymbol = T.type_alias { T.any(Symbol, String) }

                EKM = T.let(
                  :ekm,
                  OpenAI::Admin::Organization::ExternalKeyCreateParams::Body::Aws::Purpose::TaggedSymbol
                )
                PSP_DECRYPTION = T.let(
                  :psp_decryption,
                  OpenAI::Admin::Organization::ExternalKeyCreateParams::Body::Aws::Purpose::TaggedSymbol
                )

                sig {
                  override.returns(
                    T::Array[OpenAI::Admin::Organization::ExternalKeyCreateParams::Body::Aws::Purpose::TaggedSymbol]
                  )
                }
                def self.values
                end
              end
            end

            class Gcp < OpenAI::Internal::Type::BaseModel
              OrHash = T.type_alias do
                T.any(
                  OpenAI::Admin::Organization::ExternalKeyCreateParams::Body::Gcp,
                  OpenAI::Internal::AnyHash
                )
              end

              # The aud field in the identity token OpenAI will pass in the call to the
              # customer's GCP STS. This must be the OpenAI organization ID or an API project ID
              # that belongs to the organization.
              sig { returns(String) }
              attr_accessor :audience

              # The region where your Key Management System master key is located
              sig { returns(String) }
              attr_accessor :kms_key_location

              # The name of the Key Management System master key you manage
              sig { returns(String) }
              attr_accessor :kms_key_name

              # The Key Management System key ring for the master key you manage
              sig { returns(String) }
              attr_accessor :kms_key_ring_name

              # The string GCP project name where your KMS resides
              sig { returns(String) }
              attr_accessor :kms_project_id

              # A friendly name to identify this config
              sig { returns(String) }
              attr_accessor :name

              sig { returns(Symbol) }
              attr_accessor :type

              # The pool containing the Workload Identity provider that you registered for
              # OpenAI
              sig { returns(String) }
              attr_accessor :workload_identity_pool_id

              # The numeric GCP project number where you registered OpenAI's workload identity
              sig { returns(String) }
              attr_accessor :workload_identity_project_number

              # The Workload Identity provider that you registered for OpenAI
              sig { returns(String) }
              attr_accessor :workload_identity_provider_id

              # An exact CryptoKeyVersion number. Required for PSP decryption; not accepted for
              # EKM.
              sig { returns(T.nilable(String)) }
              attr_reader :kms_key_version

              sig { params(kms_key_version: String).void }
              attr_writer :kms_key_version

              sig {
                returns(T.nilable(OpenAI::Admin::Organization::ExternalKeyCreateParams::Body::Gcp::Purpose::OrSymbol))
              }
              attr_reader :purpose

              sig {
                params(purpose: OpenAI::Admin::Organization::ExternalKeyCreateParams::Body::Gcp::Purpose::OrSymbol).void
              }
              attr_writer :purpose

              sig do
                params(

                  audience: String,

                  kms_key_location: String,

                  kms_key_name: String,

                  kms_key_ring_name: String,

                  kms_project_id: String,

                  name: String,

                  workload_identity_pool_id: String,

                  workload_identity_project_number: String,

                  workload_identity_provider_id: String,

                  kms_key_version: String,

                  purpose: OpenAI::Admin::Organization::ExternalKeyCreateParams::Body::Gcp::Purpose::OrSymbol,

                  type: Symbol
                )
                  .returns(T.attached_class)
              end
              def self.new(

                # The aud field in the identity token OpenAI will pass in the call to the
                # customer's GCP STS. This must be the OpenAI organization ID or an API project ID
                # that belongs to the organization.
                audience:,

                # The region where your Key Management System master key is located
                kms_key_location:,

                # The name of the Key Management System master key you manage
                kms_key_name:,

                # The Key Management System key ring for the master key you manage
                kms_key_ring_name:,

                # The string GCP project name where your KMS resides
                kms_project_id:,

                # A friendly name to identify this config
                name:,

                # The pool containing the Workload Identity provider that you registered for
                # OpenAI
                workload_identity_pool_id:,

                # The numeric GCP project number where you registered OpenAI's workload identity
                workload_identity_project_number:,

                # The Workload Identity provider that you registered for OpenAI
                workload_identity_provider_id:,

                # An exact CryptoKeyVersion number. Required for PSP decryption; not accepted for
                # EKM.
                kms_key_version: nil,

                purpose: nil,

                type: :gcp
              )
              end

              sig do
                override.returns(
                  {
                    audience: String,
                    kms_key_location: String,
                    kms_key_name: String,
                    kms_key_ring_name: String,
                    kms_project_id: String,
                    name: String,
                    type: Symbol,
                    workload_identity_pool_id: String,
                    workload_identity_project_number: String,
                    workload_identity_provider_id: String,
                    kms_key_version: String,
                    purpose: OpenAI::Admin::Organization::ExternalKeyCreateParams::Body::Gcp::Purpose::OrSymbol
                  }
                )
              end
              def to_hash
              end

              module Purpose
                extend OpenAI::Internal::Type::Enum

                TaggedSymbol = T.type_alias {
                  T.all(Symbol, OpenAI::Admin::Organization::ExternalKeyCreateParams::Body::Gcp::Purpose)
                }
                OrSymbol = T.type_alias { T.any(Symbol, String) }

                EKM = T.let(
                  :ekm,
                  OpenAI::Admin::Organization::ExternalKeyCreateParams::Body::Gcp::Purpose::TaggedSymbol
                )
                PSP_DECRYPTION = T.let(
                  :psp_decryption,
                  OpenAI::Admin::Organization::ExternalKeyCreateParams::Body::Gcp::Purpose::TaggedSymbol
                )

                sig {
                  override.returns(
                    T::Array[OpenAI::Admin::Organization::ExternalKeyCreateParams::Body::Gcp::Purpose::TaggedSymbol]
                  )
                }
                def self.values
                end
              end
            end

            class Azure < OpenAI::Internal::Type::BaseModel
              OrHash = T.type_alias do
                T.any(
                  OpenAI::Admin::Organization::ExternalKeyCreateParams::Body::Azure,
                  OpenAI::Internal::AnyHash
                )
              end

              # The name of the Azure Key Vault master key that you manage
              sig { returns(String) }
              attr_accessor :key_name

              # A friendly name to identify this config
              sig { returns(String) }
              attr_accessor :name

              # Your Azure tenant UUID
              sig { returns(String) }
              attr_accessor :tenant_id

              sig { returns(Symbol) }
              attr_accessor :type

              # The URI of the Azure vault containing the master key you manage
              sig { returns(String) }
              attr_accessor :vault_uri

              # An exact Azure Key Vault key version. Required for PSP decryption; not accepted
              # for EKM.
              sig { returns(T.nilable(String)) }
              attr_reader :key_version

              sig { params(key_version: String).void }
              attr_writer :key_version

              sig {
                returns(T.nilable(OpenAI::Admin::Organization::ExternalKeyCreateParams::Body::Azure::Purpose::OrSymbol))
              }
              attr_reader :purpose

              sig {
                params(purpose: OpenAI::Admin::Organization::ExternalKeyCreateParams::Body::Azure::Purpose::OrSymbol)
                  .void
              }
              attr_writer :purpose

              sig do
                params(

                  key_name: String,

                  name: String,

                  tenant_id: String,

                  vault_uri: String,

                  key_version: String,

                  purpose: OpenAI::Admin::Organization::ExternalKeyCreateParams::Body::Azure::Purpose::OrSymbol,

                  type: Symbol
                )
                  .returns(T.attached_class)
              end
              def self.new(

                # The name of the Azure Key Vault master key that you manage
                key_name:,

                # A friendly name to identify this config
                name:,

                # Your Azure tenant UUID
                tenant_id:,

                # The URI of the Azure vault containing the master key you manage
                vault_uri:,

                # An exact Azure Key Vault key version. Required for PSP decryption; not accepted
                # for EKM.
                key_version: nil,

                purpose: nil,

                type: :azure
              )
              end

              sig do
                override.returns(
                  {
                    key_name: String,
                    name: String,
                    tenant_id: String,
                    type: Symbol,
                    vault_uri: String,
                    key_version: String,
                    purpose: OpenAI::Admin::Organization::ExternalKeyCreateParams::Body::Azure::Purpose::OrSymbol
                  }
                )
              end
              def to_hash
              end

              module Purpose
                extend OpenAI::Internal::Type::Enum

                TaggedSymbol = T.type_alias {
                  T.all(Symbol, OpenAI::Admin::Organization::ExternalKeyCreateParams::Body::Azure::Purpose)
                }
                OrSymbol = T.type_alias { T.any(Symbol, String) }

                EKM = T.let(
                  :ekm,
                  OpenAI::Admin::Organization::ExternalKeyCreateParams::Body::Azure::Purpose::TaggedSymbol
                )
                PSP_DECRYPTION = T.let(
                  :psp_decryption,
                  OpenAI::Admin::Organization::ExternalKeyCreateParams::Body::Azure::Purpose::TaggedSymbol
                )

                sig {
                  override.returns(
                    T::Array[OpenAI::Admin::Organization::ExternalKeyCreateParams::Body::Azure::Purpose::TaggedSymbol]
                  )
                }
                def self.values
                end
              end
            end

            sig { override.returns(T::Array[OpenAI::Admin::Organization::ExternalKeyCreateParams::Body::Variants]) }
            def self.variants
            end

          end

        end

      end

    end

  end
end
