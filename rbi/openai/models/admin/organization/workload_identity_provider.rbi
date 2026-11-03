# typed: strong

module OpenAI
  module Models

    module Admin

      module Organization

        class WorkloadIdentityProvider < OpenAI::Internal::Type::BaseModel

          OrHash = T.type_alias do
            T.any(
              OpenAI::Admin::Organization::WorkloadIdentityProvider,
              OpenAI::Internal::AnyHash
            )
          end

          sig { returns(String) }
          attr_accessor :id

          sig { returns(T::Array[OpenAI::Admin::Organization::WorkloadIdentityProvider::AttributeTransformation]) }
          attr_accessor :attribute_transformations

          sig { returns(String) }
          attr_accessor :audience

          sig { returns(Integer) }
          attr_accessor :created_at

          sig { returns(T.nilable(String)) }
          attr_accessor :description

          sig { returns(T::Boolean) }
          attr_accessor :enabled

          sig { returns(String) }
          attr_accessor :issuer

          sig { returns(String) }
          attr_accessor :name

          sig { returns(Symbol) }
          attr_accessor :object

          sig { returns(Symbol) }
          attr_accessor :type

          sig { returns(Integer) }
          attr_accessor :updated_at

          sig { returns(OpenAI::Admin::Organization::WorkloadIdentityProvider::Verification::Variants) }
          attr_accessor :verification

          sig do
            params(

              id: String,

              attribute_transformations: T::Array[
                OpenAI::Admin::Organization::WorkloadIdentityProvider::AttributeTransformation::OrHash
              ],

              audience: String,

              created_at: Integer,

              description: T.nilable(String),

              enabled: T::Boolean,

              issuer: String,

              name: String,

              updated_at: Integer,

              verification: T.any(
                OpenAI::Admin::Organization::WorkloadIdentityProvider::Verification::Discovery::OrHash,
                OpenAI::Admin::Organization::WorkloadIdentityProvider::Verification::UploadedJwks::OrHash
              ),

              object: Symbol,

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            id:,

            attribute_transformations:,

            audience:,

            created_at:,

            description:,

            enabled:,

            issuer:,

            name:,

            updated_at:,

            verification:,

            object: :"organization.workload_identity_provider",

            type: :oidc
          )
          end

          sig do
            override.returns(
              {
                id: String,
                attribute_transformations: T::Array[
                  OpenAI::Admin::Organization::WorkloadIdentityProvider::AttributeTransformation
                ],
                audience: String,
                created_at: Integer,
                description: T.nilable(String),
                enabled: T::Boolean,
                issuer: String,
                name: String,
                object: Symbol,
                type: Symbol,
                updated_at: Integer,
                verification: OpenAI::Admin::Organization::WorkloadIdentityProvider::Verification::Variants
              }
            )
          end
          def to_hash
          end

          class AttributeTransformation < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::Admin::Organization::WorkloadIdentityProvider::AttributeTransformation,
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
                OpenAI::Admin::Organization::WorkloadIdentityProvider::Verification::Discovery,
                OpenAI::Admin::Organization::WorkloadIdentityProvider::Verification::UploadedJwks
              )
            }

            class Discovery < OpenAI::Internal::Type::BaseModel
              OrHash = T.type_alias do
                T.any(
                  OpenAI::Admin::Organization::WorkloadIdentityProvider::Verification::Discovery,
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
                  OpenAI::Admin::Organization::WorkloadIdentityProvider::Verification::UploadedJwks,
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
              override.returns(T::Array[OpenAI::Admin::Organization::WorkloadIdentityProvider::Verification::Variants])
            }
            def self.variants
            end

          end

        end

      end

    end

  end
end
