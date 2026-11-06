# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        # @see OpenAI::Resources::Admin::Organization::WorkloadIdentityProviders#create
        class WorkloadIdentityProviderCreateParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          # @!attribute audience
          #
          #   @return [String]
          required :audience, String

          # @!attribute issuer
          #
          #   @return [String]
          required :issuer, String

          # @!attribute name
          #
          #   @return [String]
          required :name, String

          # @!attribute type
          #
          #   @return [Symbol, :oidc]
          required :type, const: :oidc

          # @!attribute attribute_transformations
          #
          #   @return [Array<OpenAI::Models::Admin::Organization::WorkloadIdentityProviderCreateParams::AttributeTransformation>, nil]
          optional(
            :attribute_transformations,
            -> {
              OpenAI::Internal::Type::ArrayOf[
                OpenAI::Admin::Organization::WorkloadIdentityProviderCreateParams::AttributeTransformation
              ]
            }
          )

          # @!attribute description
          #
          #   @return [String, nil]
          optional :description, String

          # @!attribute enabled
          #
          #   @return [Boolean, nil]
          optional :enabled, OpenAI::Internal::Type::Boolean

          # @!attribute verification
          #
          #   @return [OpenAI::Models::Admin::Organization::WorkloadIdentityProviderCreateParams::Verification::Discovery, OpenAI::Models::Admin::Organization::WorkloadIdentityProviderCreateParams::Verification::UploadedJwks, nil]
          optional(
            :verification,
            union: -> { OpenAI::Admin::Organization::WorkloadIdentityProviderCreateParams::Verification }
          )

          # @!method initialize(audience:, issuer:, name:, attribute_transformations: nil, description: nil, enabled: nil, verification: nil, type: :oidc, request_options: {})
          #   @param audience [String]
          #   @param issuer [String]
          #   @param name [String]
          #   @param attribute_transformations [Array<OpenAI::Models::Admin::Organization::WorkloadIdentityProviderCreateParams::AttributeTransformation>]
          #   @param description [String]
          #   @param enabled [Boolean]
          #   @param verification [OpenAI::Models::Admin::Organization::WorkloadIdentityProviderCreateParams::Verification::Discovery, OpenAI::Models::Admin::Organization::WorkloadIdentityProviderCreateParams::Verification::UploadedJwks]
          #   @param type [Symbol, :oidc]
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

            discriminator :type

            variant(
              :discovery,
              -> { OpenAI::Admin::Organization::WorkloadIdentityProviderCreateParams::Verification::Discovery }
            )

            variant(
              :uploaded_jwks,
              -> { OpenAI::Admin::Organization::WorkloadIdentityProviderCreateParams::Verification::UploadedJwks }
            )

            class Discovery < OpenAI::Internal::Type::BaseModel
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

            class UploadedJwks < OpenAI::Internal::Type::BaseModel
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
            #   @return [Array(OpenAI::Models::Admin::Organization::WorkloadIdentityProviderCreateParams::Verification::Discovery, OpenAI::Models::Admin::Organization::WorkloadIdentityProviderCreateParams::Verification::UploadedJwks)]
          end
        end
      end
    end
  end
end
