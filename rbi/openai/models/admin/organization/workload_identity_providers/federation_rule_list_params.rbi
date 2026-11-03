# typed: strong

module OpenAI
  module Models

    module Admin

      module Organization

        module WorkloadIdentityProviders

          class FederationRuleListParams < OpenAI::Internal::Type::BaseModel

            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            OrHash = T.type_alias do
              T.any(
                OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRuleListParams,
                OpenAI::Internal::AnyHash
              )
            end

            sig { returns(String) }
            attr_accessor :workload_identity_provider_id

            sig { returns(T.nilable(String)) }
            attr_reader :after

            sig { params(after: String).void }
            attr_writer :after

            sig { returns(T.nilable(Integer)) }
            attr_reader :limit

            sig { params(limit: Integer).void }
            attr_writer :limit

            sig {
              returns(
                T.nilable(
                  OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRuleListParams::Order::OrSymbol
                )
              )
            }
            attr_reader :order

            sig {
              params(
                order: OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRuleListParams::Order::OrSymbol
              )
                .void
            }
            attr_writer :order

            sig { returns(T.nilable(String)) }
            attr_reader :service_account_id

            sig { params(service_account_id: String).void }
            attr_writer :service_account_id

            sig do
              params(

                workload_identity_provider_id: String,

                after: String,

                limit: Integer,

                order: OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRuleListParams::Order::OrSymbol,

                service_account_id: String,

                request_options: OpenAI::RequestOptions::OrHash
              )
                .returns(T.attached_class)
            end
            def self.new(

              workload_identity_provider_id:,

              after: nil,

              limit: nil,

              order: nil,

              service_account_id: nil,

              request_options: {}
            )
            end

            sig do
              override.returns(
                {
                  workload_identity_provider_id: String,
                  after: String,
                  limit: Integer,
                  order: OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRuleListParams::Order::OrSymbol,
                  service_account_id: String,
                  request_options: OpenAI::RequestOptions
                }
              )
            end
            def to_hash
            end

            module Order
              extend OpenAI::Internal::Type::Union

              Variants = T.type_alias {
                OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRuleListParams::Order::TaggedSymbol
              }

              sig {
                override.returns(
                  T::Array[
                    OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRuleListParams::Order::Variants
                  ]
                )
              }
              def self.variants
              end

              TaggedSymbol = T.type_alias do
                T.all(Symbol, OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRuleListParams::Order)
              end

              OrSymbol = T.type_alias { T.any(Symbol, String) }

              ASC = T.let(
                :asc,
                OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRuleListParams::Order::TaggedSymbol
              )
              DESC = T.let(
                :desc,
                OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRuleListParams::Order::TaggedSymbol
              )

            end

          end

        end

      end

    end

  end
end
