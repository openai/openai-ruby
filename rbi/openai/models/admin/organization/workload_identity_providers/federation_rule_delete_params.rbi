# typed: strong

module OpenAI
  module Models

    module Admin

      module Organization

        module WorkloadIdentityProviders

          class FederationRuleDeleteParams < OpenAI::Internal::Type::BaseModel

            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            OrHash = T.type_alias do
              T.any(
                OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRuleDeleteParams,
                OpenAI::Internal::AnyHash
              )
            end

            sig { returns(String) }
            attr_accessor :workload_identity_provider_id

            sig { returns(String) }
            attr_accessor :workload_identity_federation_rule_id

            sig do
              params(

                workload_identity_provider_id: String,

                workload_identity_federation_rule_id: String,

                request_options: OpenAI::RequestOptions::OrHash
              )
                .returns(T.attached_class)
            end
            def self.new(

              workload_identity_provider_id:,

              workload_identity_federation_rule_id:,

              request_options: {}
            )
            end

            sig do
              override.returns(
                {
                  workload_identity_provider_id: String,
                  workload_identity_federation_rule_id: String,
                  request_options: OpenAI::RequestOptions
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
end
