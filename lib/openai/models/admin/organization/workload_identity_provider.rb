# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        # @see OpenAI::Resources::Admin::Organization::WorkloadIdentityProviders#create
        class WorkloadIdentityProvider < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #
          #   @return [String]
          required :id, String

          # @!attribute attribute_transformations
          #
          #   @return [Array<OpenAI::Models::Admin::Organization::WorkloadIdentityProvider::AttributeTransformation>]
          required(
            :attribute_transformations,
            -> {
              OpenAI::Internal::Type::ArrayOf[
                OpenAI::Admin::Organization::WorkloadIdentityProvider::AttributeTransformation
              ]
            }
          )

          # @!attribute audience
          #
          #   @return [String]
          required :audience, String

          # @!attribute created_at
          #
          #   @return [Integer]
          required :created_at, Integer

          # @!attribute description
          #
          #   @return [String, nil]
          required :description, String, nil?: true

          # @!attribute enabled
          #
          #   @return [Boolean]
          required :enabled, OpenAI::Internal::Type::Boolean

          # @!attribute issuer
          #
          #   @return [String]
          required :issuer, String

          # @!attribute name
          #
          #   @return [String]
          required :name, String

          # @!attribute object
          #
          #   @return [Symbol, :"organization.workload_identity_provider"]
          required :object, const: :"organization.workload_identity_provider"

          # @!attribute type
          #
          #   @return [Symbol, :oidc]
          required :type, const: :oidc

          # @!attribute updated_at
          #
          #   @return [Integer]
          required :updated_at, Integer

          # @!attribute verification
          #
          #   @return [OpenAI::Models::Admin::Organization::WorkloadIdentityProvider::Verification::Discovery, OpenAI::Models::Admin::Organization::WorkloadIdentityProvider::Verification::UploadedJwks]
          required :verification, union: -> { OpenAI::Admin::Organization::WorkloadIdentityProvider::Verification }

          # @!method initialize(id:, attribute_transformations:, audience:, created_at:, description:, enabled:, issuer:, name:, updated_at:, verification:, object: :"organization.workload_identity_provider", type: :oidc)
          #   @param id [String]
          #   @param attribute_transformations [Array<OpenAI::Models::Admin::Organization::WorkloadIdentityProvider::AttributeTransformation>]
          #   @param audience [String]
          #   @param created_at [Integer]
          #   @param description [String, nil]
          #   @param enabled [Boolean]
          #   @param issuer [String]
          #   @param name [String]
          #   @param updated_at [Integer]
          #   @param verification [OpenAI::Models::Admin::Organization::WorkloadIdentityProvider::Verification::Discovery, OpenAI::Models::Admin::Organization::WorkloadIdentityProvider::Verification::UploadedJwks]
          #   @param object [Symbol, :"organization.workload_identity_provider"]
          #   @param type [Symbol, :oidc]

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

          # @see OpenAI::Models::Admin::Organization::WorkloadIdentityProvider#verification
          module Verification
            extend OpenAI::Internal::Type::Union

            discriminator :type

            variant :discovery, -> { OpenAI::Admin::Organization::WorkloadIdentityProvider::Verification::Discovery }

            variant(
              :uploaded_jwks,
              -> { OpenAI::Admin::Organization::WorkloadIdentityProvider::Verification::UploadedJwks }
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
            #   @return [Array(OpenAI::Models::Admin::Organization::WorkloadIdentityProvider::Verification::Discovery, OpenAI::Models::Admin::Organization::WorkloadIdentityProvider::Verification::UploadedJwks)]
          end
        end
      end
    end
  end
end
