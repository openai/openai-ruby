# typed: strong

module OpenAI
  module Models

    module Admin

      module Organization

        module WorkloadIdentityProviders

          class FederationRuleUpdateParams < OpenAI::Internal::Type::BaseModel

            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            OrHash = T.type_alias do
              T.any(
                OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRuleUpdateParams,
                OpenAI::Internal::AnyHash
              )
            end

            sig { returns(String) }
            attr_accessor :workload_identity_provider_id

            sig { returns(String) }
            attr_accessor :workload_identity_federation_rule_id

            sig {
              returns(
                T.nilable(
                  T::Hash[
                    Symbol,
                    OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRuleUpdateParams::AttributeMatcher::Variants
                  ]
                )
              )
            }
            attr_reader :attribute_matchers

            sig {
              params(
                attribute_matchers: T::Hash[
                  Symbol,
                  OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRuleUpdateParams::AttributeMatcher::Variants
                ]
              )
                .void
            }
            attr_writer :attribute_matchers

            sig { returns(T.nilable(String)) }
            attr_accessor :description

            sig { returns(T.nilable(T::Boolean)) }
            attr_reader :enabled

            sig { params(enabled: T::Boolean).void }
            attr_writer :enabled

            sig { returns(T.nilable(String)) }
            attr_accessor :name

            sig {
              returns(
                T.nilable(
                  T.any(
                    OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRuleUpdateParams::Permissions::DefaultPermissionsParam,
                    OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRuleUpdateParams::Permissions::RestrictedPermissionsParam
                  )
                )
              )
            }
            attr_reader :permissions

            sig {
              params(
                permissions: T.any(
                  OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRuleUpdateParams::Permissions::DefaultPermissionsParam::OrHash,
                  OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRuleUpdateParams::Permissions::RestrictedPermissionsParam::OrHash
                )
              )
                .void
            }
            attr_writer :permissions

            sig do
              params(

                workload_identity_provider_id: String,

                workload_identity_federation_rule_id: String,

                attribute_matchers: T::Hash[
                  Symbol,
                  OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRuleUpdateParams::AttributeMatcher::Variants
                ],

                description: T.nilable(String),

                enabled: T::Boolean,

                name: T.nilable(String),

                permissions: T.any(
                  OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRuleUpdateParams::Permissions::DefaultPermissionsParam::OrHash,
                  OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRuleUpdateParams::Permissions::RestrictedPermissionsParam::OrHash
                ),

                request_options: OpenAI::RequestOptions::OrHash
              )
                .returns(T.attached_class)
            end
            def self.new(

              workload_identity_provider_id:,

              workload_identity_federation_rule_id:,

              attribute_matchers: nil,

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
                  workload_identity_federation_rule_id: String,
                  attribute_matchers: T::Hash[
                    Symbol,
                    OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRuleUpdateParams::AttributeMatcher::Variants
                  ],
                  description: T.nilable(String),
                  enabled: T::Boolean,
                  name: T.nilable(String),
                  permissions: T.any(
                    OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRuleUpdateParams::Permissions::DefaultPermissionsParam,
                    OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRuleUpdateParams::Permissions::RestrictedPermissionsParam
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
                    OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRuleUpdateParams::AttributeMatcher::Variants
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
                  OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRuleUpdateParams::Permissions::DefaultPermissionsParam,
                  OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRuleUpdateParams::Permissions::RestrictedPermissionsParam
                )
              }

              class DefaultPermissionsParam < OpenAI::Internal::Type::BaseModel
                OrHash = T.type_alias do
                  T.any(
                    OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRuleUpdateParams::Permissions::DefaultPermissionsParam,
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

              class RestrictedPermissionsParam < OpenAI::Internal::Type::BaseModel
                OrHash = T.type_alias do
                  T.any(
                    OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRuleUpdateParams::Permissions::RestrictedPermissionsParam,
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
                    OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRuleUpdateParams::Permissions::Variants
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
