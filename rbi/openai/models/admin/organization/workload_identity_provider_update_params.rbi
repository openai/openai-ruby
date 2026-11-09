# typed: strong

module OpenAI
  module Models

    module Admin

      module Organization

        class WorkloadIdentityProviderUpdateParams < OpenAI::Internal::Type::BaseModel

          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          OrHash = T.type_alias do
            T.any(
              OpenAI::Admin::Organization::WorkloadIdentityProviderUpdateParams,
              OpenAI::Internal::AnyHash
            )
          end

          sig { returns(String) }
          attr_accessor :workload_identity_provider_id

          sig {
            returns(
              T.nilable(
                T::Array[OpenAI::Admin::Organization::WorkloadIdentityProviderUpdateParams::AttributeTransformation]
              )
            )
          }
          attr_reader :attribute_transformations

          sig {
            params(
              attribute_transformations: T::Array[
                OpenAI::Admin::Organization::WorkloadIdentityProviderUpdateParams::AttributeTransformation::OrHash
              ]
            )
              .void
          }
          attr_writer :attribute_transformations

          sig { returns(T.nilable(String)) }
          attr_reader :audience

          sig { params(audience: String).void }
          attr_writer :audience

          sig { returns(T.nilable(String)) }
          attr_accessor :description

          sig { returns(T.nilable(T::Boolean)) }
          attr_reader :enabled

          sig { params(enabled: T::Boolean).void }
          attr_writer :enabled

          sig { returns(T.nilable(String)) }
          attr_reader :issuer

          sig { params(issuer: String).void }
          attr_writer :issuer

          sig { returns(T.nilable(String)) }
          attr_reader :name

          sig { params(name: String).void }
          attr_writer :name

          sig {
            returns(
              T.nilable(
                T.any(
                  OpenAI::Admin::Organization::WorkloadIdentityProviderUpdateParams::Verification::DiscoveryVerificationParam,
                  OpenAI::Admin::Organization::WorkloadIdentityProviderUpdateParams::Verification::UploadedJwksVerificationParam
                )
              )
            )
          }
          attr_reader :verification

          sig {
            params(
              verification: T.any(
                OpenAI::Admin::Organization::WorkloadIdentityProviderUpdateParams::Verification::DiscoveryVerificationParam::OrHash,
                OpenAI::Admin::Organization::WorkloadIdentityProviderUpdateParams::Verification::UploadedJwksVerificationParam::OrHash
              )
            )
              .void
          }
          attr_writer :verification

          sig do
            params(

              workload_identity_provider_id: String,

              attribute_transformations: T::Array[
                OpenAI::Admin::Organization::WorkloadIdentityProviderUpdateParams::AttributeTransformation::OrHash
              ],

              audience: String,

              description: T.nilable(String),

              enabled: T::Boolean,

              issuer: String,

              name: String,

              verification: T.any(
                OpenAI::Admin::Organization::WorkloadIdentityProviderUpdateParams::Verification::DiscoveryVerificationParam::OrHash,
                OpenAI::Admin::Organization::WorkloadIdentityProviderUpdateParams::Verification::UploadedJwksVerificationParam::OrHash
              ),

              request_options: OpenAI::RequestOptions::OrHash
            )
              .returns(T.attached_class)
          end
          def self.new(

            workload_identity_provider_id:,

            attribute_transformations: nil,

            audience: nil,

            description: nil,

            enabled: nil,

            issuer: nil,

            name: nil,

            verification: nil,

            request_options: {}
          )
          end

          sig do
            override.returns(
              {
                workload_identity_provider_id: String,
                attribute_transformations: T::Array[
                  OpenAI::Admin::Organization::WorkloadIdentityProviderUpdateParams::AttributeTransformation
                ],
                audience: String,
                description: T.nilable(String),
                enabled: T::Boolean,
                issuer: String,
                name: String,
                verification: T.any(
                  OpenAI::Admin::Organization::WorkloadIdentityProviderUpdateParams::Verification::DiscoveryVerificationParam,
                  OpenAI::Admin::Organization::WorkloadIdentityProviderUpdateParams::Verification::UploadedJwksVerificationParam
                ),
                request_options: OpenAI::RequestOptions
              }
            )
          end
          def to_hash
          end

          class AttributeTransformation < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::Admin::Organization::WorkloadIdentityProviderUpdateParams::AttributeTransformation,
                OpenAI::Internal::AnyHash
              )
            end

            sig { returns(String) }
            attr_accessor :attribute

            sig { returns(String) }
            attr_accessor :expression

            sig do
              params(

                attribute: String,

                expression: String
              )
                .returns(T.attached_class)
            end
            def self.new(

              attribute:,

              expression:
            )
            end

            sig do
              override.returns(
                {attribute: String, expression: String}
              )
            end
            def to_hash
            end

          end

          module Verification
            extend OpenAI::Internal::Type::Union

            Variants = T.type_alias {
              T.any(
                OpenAI::Admin::Organization::WorkloadIdentityProviderUpdateParams::Verification::DiscoveryVerificationParam,
                OpenAI::Admin::Organization::WorkloadIdentityProviderUpdateParams::Verification::UploadedJwksVerificationParam
              )
            }

            class DiscoveryVerificationParam < OpenAI::Internal::Type::BaseModel
              OrHash = T.type_alias do
                T.any(
                  OpenAI::Admin::Organization::WorkloadIdentityProviderUpdateParams::Verification::DiscoveryVerificationParam,
                  OpenAI::Internal::AnyHash
                )
              end

              sig { returns(T.nilable(String)) }
              attr_accessor :discovery_url

              sig { returns(Symbol) }
              attr_accessor :type

              sig do
                params(

                  discovery_url: T.nilable(String),

                  type: Symbol
                )
                  .returns(T.attached_class)
              end
              def self.new(

                discovery_url:,

                type: :discovery
              )
              end

              sig do
                override.returns(
                  {discovery_url: T.nilable(String), type: Symbol}
                )
              end
              def to_hash
              end

            end

            class UploadedJwksVerificationParam < OpenAI::Internal::Type::BaseModel
              OrHash = T.type_alias do
                T.any(
                  OpenAI::Admin::Organization::WorkloadIdentityProviderUpdateParams::Verification::UploadedJwksVerificationParam,
                  OpenAI::Internal::AnyHash
                )
              end

              sig { returns(T::Hash[Symbol, T.anything]) }
              attr_accessor :jwks

              sig { returns(Symbol) }
              attr_accessor :type

              sig do
                params(

                  jwks: T::Hash[Symbol, T.anything],

                  type: Symbol
                )
                  .returns(T.attached_class)
              end
              def self.new(

                jwks:,

                type: :uploaded_jwks
              )
              end

              sig do
                override.returns(
                  {jwks: T::Hash[Symbol, T.anything], type: Symbol}
                )
              end
              def to_hash
              end

            end

            sig {
              override.returns(
                T::Array[OpenAI::Admin::Organization::WorkloadIdentityProviderUpdateParams::Verification::Variants]
              )
            }
            def self.variants
            end

          end

        end

      end

    end

  end
end
