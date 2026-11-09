# typed: strong

module OpenAI
  module Models

    module Admin

      module Organization

        module WorkloadIdentityProviders

          class FederationRule < OpenAI::Internal::Type::BaseModel

            OrHash = T.type_alias do
              T.any(
                OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRule,
                OpenAI::Internal::AnyHash
              )
            end

            sig { returns(String) }
            attr_accessor :id

            sig {
              returns(
                T::Hash[
                  Symbol,
                  OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRule::AttributeMatcher::Variants
                ]
              )
            }
            attr_accessor :attribute_matchers

            sig { returns(Integer) }
            attr_accessor :created_at

            sig { returns(T.nilable(String)) }
            attr_accessor :description

            sig { returns(T::Boolean) }
            attr_accessor :enabled

            sig { returns(T.nilable(String)) }
            attr_accessor :name

            sig { returns(Symbol) }
            attr_accessor :object

            sig {
              returns(OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRule::Permissions::Variants)
            }
            attr_accessor :permissions

            sig { returns(String) }
            attr_accessor :project_id

            sig { returns(String) }
            attr_accessor :service_account_id

            sig { returns(Integer) }
            attr_accessor :updated_at

            sig { returns(String) }
            attr_accessor :workload_identity_provider_id

            sig do
              params(

                id: String,

                attribute_matchers: T::Hash[
                  Symbol,
                  OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRule::AttributeMatcher::Variants
                ],

                created_at: Integer,

                description: T.nilable(String),

                enabled: T::Boolean,

                name: T.nilable(String),

                permissions: T.any(
                  OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRule::Permissions::ServiceAccountDefault::OrHash,
                  OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRule::Permissions::Restricted::OrHash
                ),

                project_id: String,

                service_account_id: String,

                updated_at: Integer,

                workload_identity_provider_id: String,

                object: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(

              id:,

              attribute_matchers:,

              created_at:,

              description:,

              enabled:,

              name:,

              permissions:,

              project_id:,

              service_account_id:,

              updated_at:,

              workload_identity_provider_id:,

              object: :"organization.workload_identity_federation_rule"
            )
            end

            sig do
              override.returns(
                {
                  id: String,
                  attribute_matchers: T::Hash[
                    Symbol,
                    OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRule::AttributeMatcher::Variants
                  ],
                  created_at: Integer,
                  description: T.nilable(String),
                  enabled: T::Boolean,
                  name: T.nilable(String),
                  object: Symbol,
                  permissions: OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRule::Permissions::Variants,
                  project_id: String,
                  service_account_id: String,
                  updated_at: Integer,
                  workload_identity_provider_id: String
                }
              )
            end
            def to_hash
            end

            module AttributeMatcher
              extend OpenAI::Internal::Type::Union

              Variants = T.type_alias { T.any(String, T::Boolean, Integer, Float) }

              sig {
                override.returns(
                  T::Array[
                    OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRule::AttributeMatcher::Variants
                  ]
                )
              }
              def self.variants
              end

            end

            module Permissions
              extend OpenAI::Internal::Type::Union

              Variants = T.type_alias {
                T.any(
                  OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRule::Permissions::ServiceAccountDefault,
                  OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRule::Permissions::Restricted
                )
              }

              class ServiceAccountDefault < OpenAI::Internal::Type::BaseModel
                OrHash = T.type_alias do
                  T.any(
                    OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRule::Permissions::ServiceAccountDefault,
                    OpenAI::Internal::AnyHash
                  )
                end

                sig { returns(Symbol) }
                attr_accessor :type

                sig do
                  params(

                    type: Symbol
                  )
                    .returns(T.attached_class)
                end
                def self.new(

                  type: :service_account_default
                )
                end

                sig do
                  override.returns(
                    {type: Symbol}
                  )
                end
                def to_hash
                end

              end

              class Restricted < OpenAI::Internal::Type::BaseModel
                OrHash = T.type_alias do
                  T.any(
                    OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRule::Permissions::Restricted,
                    OpenAI::Internal::AnyHash
                  )
                end

                sig { returns(T::Array[String]) }
                attr_accessor :scopes

                sig { returns(Symbol) }
                attr_accessor :type

                sig do
                  params(

                    scopes: T::Array[String],

                    type: Symbol
                  )
                    .returns(T.attached_class)
                end
                def self.new(

                  scopes:,

                  type: :restricted
                )
                end

                sig do
                  override.returns(
                    {scopes: T::Array[String], type: Symbol}
                  )
                end
                def to_hash
                end

              end

              sig {
                override.returns(
                  T::Array[
                    OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRule::Permissions::Variants
                  ]
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
end
