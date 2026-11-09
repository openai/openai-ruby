# typed: strong

module OpenAI
  module Models

    module Admin

      module Organization

        class WorkloadIdentityProviderCreateParams < OpenAI::Internal::Type::BaseModel

          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          OrHash = T.type_alias do
            T.any(
              OpenAI::Admin::Organization::WorkloadIdentityProviderCreateParams,
              OpenAI::Internal::AnyHash
            )
          end

          sig { returns(String) }
          attr_accessor :audience

          sig { returns(String) }
          attr_accessor :issuer

          sig { returns(String) }
          attr_accessor :name

          sig { returns(Symbol) }
          attr_accessor :type

          sig {
            returns(
              T.nilable(
                T::Array[OpenAI::Admin::Organization::WorkloadIdentityProviderCreateParams::AttributeTransformation]
              )
            )
          }
          attr_reader :attribute_transformations

          sig {
            params(
              attribute_transformations: T::Array[
                OpenAI::Admin::Organization::WorkloadIdentityProviderCreateParams::AttributeTransformation::OrHash
              ]
            )
              .void
          }
          attr_writer :attribute_transformations

          sig { returns(T.nilable(String)) }
          attr_reader :description

          sig { params(description: String).void }
          attr_writer :description

          sig { returns(T.nilable(T::Boolean)) }
          attr_reader :enabled

          sig { params(enabled: T::Boolean).void }
          attr_writer :enabled

          sig {
            returns(
              T.nilable(
                T.any(
                  OpenAI::Admin::Organization::WorkloadIdentityProviderCreateParams::Verification::Discovery,
                  OpenAI::Admin::Organization::WorkloadIdentityProviderCreateParams::Verification::UploadedJwks
                )
              )
            )
          }
          attr_reader :verification

          sig {
            params(
              verification: T.any(
                OpenAI::Admin::Organization::WorkloadIdentityProviderCreateParams::Verification::Discovery::OrHash,
                OpenAI::Admin::Organization::WorkloadIdentityProviderCreateParams::Verification::UploadedJwks::OrHash
              )
            )
              .void
          }
          attr_writer :verification

          sig do
            params(

              audience: String,

              issuer: String,

              name: String,

              attribute_transformations: T::Array[
                OpenAI::Admin::Organization::WorkloadIdentityProviderCreateParams::AttributeTransformation::OrHash
              ],

              description: String,

              enabled: T::Boolean,

              verification: T.any(
                OpenAI::Admin::Organization::WorkloadIdentityProviderCreateParams::Verification::Discovery::OrHash,
                OpenAI::Admin::Organization::WorkloadIdentityProviderCreateParams::Verification::UploadedJwks::OrHash
              ),

              type: Symbol,

              request_options: OpenAI::RequestOptions::OrHash
            )
              .returns(T.attached_class)
          end
          def self.new(

            audience:,

            issuer:,

            name:,

            attribute_transformations: nil,

            description: nil,

            enabled: nil,

            verification: nil,

            type: :oidc,

            request_options: {}
          )
          end

          sig do
            override.returns(
              {
                audience: String,
                issuer: String,
                name: String,
                type: Symbol,
                attribute_transformations: T::Array[
                  OpenAI::Admin::Organization::WorkloadIdentityProviderCreateParams::AttributeTransformation
                ],
                description: String,
                enabled: T::Boolean,
                verification: T.any(
                  OpenAI::Admin::Organization::WorkloadIdentityProviderCreateParams::Verification::Discovery,
                  OpenAI::Admin::Organization::WorkloadIdentityProviderCreateParams::Verification::UploadedJwks
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
                OpenAI::Admin::Organization::WorkloadIdentityProviderCreateParams::AttributeTransformation,
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
                OpenAI::Admin::Organization::WorkloadIdentityProviderCreateParams::Verification::Discovery,
                OpenAI::Admin::Organization::WorkloadIdentityProviderCreateParams::Verification::UploadedJwks
              )
            }

            class Discovery < OpenAI::Internal::Type::BaseModel
              OrHash = T.type_alias do
                T.any(
                  OpenAI::Admin::Organization::WorkloadIdentityProviderCreateParams::Verification::Discovery,
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

            class UploadedJwks < OpenAI::Internal::Type::BaseModel
              OrHash = T.type_alias do
                T.any(
                  OpenAI::Admin::Organization::WorkloadIdentityProviderCreateParams::Verification::UploadedJwks,
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
                T::Array[OpenAI::Admin::Organization::WorkloadIdentityProviderCreateParams::Verification::Variants]
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
