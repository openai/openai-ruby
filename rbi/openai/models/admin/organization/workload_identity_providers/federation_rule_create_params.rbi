# typed: strong

module OpenAI
  module Models

    module Admin

      module Organization

        module WorkloadIdentityProviders

          class FederationRuleCreateParams < OpenAI::Internal::Type::BaseModel

            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            OrHash = T.type_alias do
              T.any(
                OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRuleCreateParams,
                OpenAI::Internal::AnyHash
              )
            end

            sig { returns(String) }
            attr_accessor :workload_identity_provider_id

            sig {
              returns(
                T::Hash[
                  Symbol,
                  OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRuleCreateParams::AttributeMatcher::Variants
                ]
              )
            }
            attr_accessor :attribute_matchers

            sig { returns(String) }
            attr_accessor :project_id

            sig { returns(String) }
            attr_accessor :service_account_id

            sig { returns(T.nilable(String)) }
            attr_reader :description

            sig { params(description: String).void }
            attr_writer :description

            sig { returns(T.nilable(T::Boolean)) }
            attr_reader :enabled

            sig { params(enabled: T::Boolean).void }
            attr_writer :enabled

            sig { returns(T.nilable(String)) }
            attr_reader :name

            sig { params(name: String).void }
            attr_writer :name

            sig {
              returns(
                T.nilable(
                  T.any(
                    OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRuleCreateParams::Permissions::ServiceAccountDefault,
                    OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRuleCreateParams::Permissions::Restricted
                  )
                )
              )
            }
            attr_reader :permissions

            sig {
              params(
                permissions: T.any(
                  OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRuleCreateParams::Permissions::ServiceAccountDefault::OrHash,
                  OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRuleCreateParams::Permissions::Restricted::OrHash
                )
              )
                .void
            }
            attr_writer :permissions

            sig do
              params(

                workload_identity_provider_id: String,

                attribute_matchers: T::Hash[
                  Symbol,
                  OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRuleCreateParams::AttributeMatcher::Variants
                ],

                project_id: String,

                service_account_id: String,

                description: String,

                enabled: T::Boolean,

                name: String,

                permissions: T.any(
                  OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRuleCreateParams::Permissions::ServiceAccountDefault::OrHash,
                  OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRuleCreateParams::Permissions::Restricted::OrHash
                ),

                request_options: OpenAI::RequestOptions::OrHash
              )
                .returns(T.attached_class)
            end
            def self.new(

              workload_identity_provider_id:,

              attribute_matchers:,

              project_id:,

              service_account_id:,

              description: nil,

              enabled: nil,

              name: nil,

              permissions: nil,

              request_options: {}
            )
            end

            sig do
              override.returns(
                {
                  workload_identity_provider_id: String,
                  attribute_matchers: T::Hash[
                    Symbol,
                    OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRuleCreateParams::AttributeMatcher::Variants
                  ],
                  project_id: String,
                  service_account_id: String,
                  description: String,
                  enabled: T::Boolean,
                  name: String,
                  permissions: T.any(
                    OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRuleCreateParams::Permissions::ServiceAccountDefault,
                    OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRuleCreateParams::Permissions::Restricted
                  ),
                  request_options: OpenAI::RequestOptions
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
                    OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRuleCreateParams::AttributeMatcher::Variants
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
                  OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRuleCreateParams::Permissions::ServiceAccountDefault,
                  OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRuleCreateParams::Permissions::Restricted
                )
              }

              class ServiceAccountDefault < OpenAI::Internal::Type::BaseModel
                OrHash = T.type_alias do
                  T.any(
                    OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRuleCreateParams::Permissions::ServiceAccountDefault,
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
                    OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRuleCreateParams::Permissions::Restricted,
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
                    OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRuleCreateParams::Permissions::Variants
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
