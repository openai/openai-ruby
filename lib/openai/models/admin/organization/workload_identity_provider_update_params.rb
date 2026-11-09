# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        # @see OpenAI::Resources::Admin::Organization::WorkloadIdentityProviders#update
        class WorkloadIdentityProviderUpdateParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          # @!attribute workload_identity_provider_id
          #
          #   @return [String]
          required :workload_identity_provider_id, String

          # @!attribute attribute_transformations
          #
          #   @return [Array<OpenAI::Models::Admin::Organization::WorkloadIdentityProviderUpdateParams::AttributeTransformation>, nil]
          optional(
            :attribute_transformations,
            -> {
              OpenAI::Internal::Type::ArrayOf[
                OpenAI::Admin::Organization::WorkloadIdentityProviderUpdateParams::AttributeTransformation
              ]
            }
          )

          # @!attribute audience
          #
          #   @return [String, nil]
          optional :audience, String

          # @!attribute description
          #
          #   @return [String, nil]
          optional :description, String, nil?: true

          # @!attribute enabled
          #
          #   @return [Boolean, nil]
          optional :enabled, OpenAI::Internal::Type::Boolean

          # @!attribute issuer
          #
          #   @return [String, nil]
          optional :issuer, String

          # @!attribute name
          #
          #   @return [String, nil]
          optional :name, String

          # @!attribute verification
          #
          #   @return [OpenAI::Models::Admin::Organization::WorkloadIdentityProviderUpdateParams::Verification::DiscoveryVerificationParam, OpenAI::Models::Admin::Organization::WorkloadIdentityProviderUpdateParams::Verification::UploadedJwksVerificationParam, nil]
          optional(
            :verification,
            union: -> { OpenAI::Admin::Organization::WorkloadIdentityProviderUpdateParams::Verification }
          )

          # @!method initialize(workload_identity_provider_id:, attribute_transformations: nil, audience: nil, description: nil, enabled: nil, issuer: nil, name: nil, verification: nil, request_options: {})
          #   @param workload_identity_provider_id [String]
          #   @param attribute_transformations [Array<OpenAI::Models::Admin::Organization::WorkloadIdentityProviderUpdateParams::AttributeTransformation>]
          #   @param audience [String]
          #   @param description [String, nil]
          #   @param enabled [Boolean]
          #   @param issuer [String]
          #   @param name [String]
          #   @param verification [OpenAI::Models::Admin::Organization::WorkloadIdentityProviderUpdateParams::Verification::DiscoveryVerificationParam, OpenAI::Models::Admin::Organization::WorkloadIdentityProviderUpdateParams::Verification::UploadedJwksVerificationParam]
          #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

          class AttributeTransformation < OpenAI::Internal::Type::BaseModel
            # @!attribute attribute
            #
            #   @return [String]
            required :attribute, String

            # @!attribute expression
            #
            #   @return [String]
            required :expression, String

            # @!method initialize(attribute:, expression:)
            #   @param attribute [String]
            #   @param expression [String]
          end

          module Verification
            extend OpenAI::Internal::Type::Union

            variant(
              -> {
                OpenAI::Admin::Organization::WorkloadIdentityProviderUpdateParams::Verification::DiscoveryVerificationParam
              }
            )

            variant(
              -> {
                OpenAI::Admin::Organization::WorkloadIdentityProviderUpdateParams::Verification::UploadedJwksVerificationParam
              }
            )

            class DiscoveryVerificationParam < OpenAI::Internal::Type::BaseModel
              # @!attribute discovery_url
              #
              #   @return [String, nil]
              required :discovery_url, String, nil?: true

              # @!attribute type
              #
              #   @return [Symbol, :discovery]
              required :type, const: :discovery

              # @!method initialize(discovery_url:, type: :discovery)
              #   @param discovery_url [String, nil]
              #   @param type [Symbol, :discovery]
            end

            class UploadedJwksVerificationParam < OpenAI::Internal::Type::BaseModel
              # @!attribute jwks
              #
              #   @return [Hash{Symbol=>Object}]
              required :jwks, OpenAI::Internal::Type::HashOf[OpenAI::Internal::Type::Unknown]

              # @!attribute type
              #
              #   @return [Symbol, :uploaded_jwks]
              required :type, const: :uploaded_jwks

              # @!method initialize(jwks:, type: :uploaded_jwks)
              #   @param jwks [Hash{Symbol=>Object}]
              #   @param type [Symbol, :uploaded_jwks]
            end

            # @!method self.variants
            #   @return [Array(OpenAI::Models::Admin::Organization::WorkloadIdentityProviderUpdateParams::Verification::DiscoveryVerificationParam, OpenAI::Models::Admin::Organization::WorkloadIdentityProviderUpdateParams::Verification::UploadedJwksVerificationParam)]
          end
        end
      end
    end
  end
end
