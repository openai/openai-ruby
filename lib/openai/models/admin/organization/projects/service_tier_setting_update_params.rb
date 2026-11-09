# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        module Projects
          # @see OpenAI::Resources::Admin::Organization::Projects::ServiceTierSettings#update
          class ServiceTierSettingUpdateParams < OpenAI::Internal::Type::BaseModel
            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            # @!attribute project_id
            #   The ID of the project
            #
            #   @return [String]
            required :project_id, String

            # @!attribute default
            #   Default tier for requests that omit service_tier or use auto.
            #
            #   @return [Symbol, OpenAI::Models::Admin::Organization::Projects::ServiceTierSettingUpdateParams::Default, nil]
            optional(
              :default,
              enum: -> { OpenAI::Admin::Organization::Projects::ServiceTierSettingUpdateParams::Default }
            )

            # @!attribute enabled_tiers
            #   Additional service tiers enabled for this project. "all" includes future tiers.
            #   An empty array allows only Standard. Organization policy and eligibility still
            #   apply.
            #
            #   @return [Symbol, :all, Array<Symbol, OpenAI::Models::Admin::Organization::Projects::ProjectOptionalServiceTier>, nil]
            optional(
              :enabled_tiers,
              union: -> { OpenAI::Admin::Organization::Projects::ServiceTierSettingUpdateParams::EnabledTiers }
            )

            # @!method initialize(project_id:, default: nil, enabled_tiers: nil, request_options: {})
            #   @param project_id [String]
            #     The ID of the project
            #
            #   @param default [Symbol, OpenAI::Models::Admin::Organization::Projects::ServiceTierSettingUpdateParams::Default]
            #     Default tier for requests that omit service_tier or use auto.
            #
            #   @param enabled_tiers [Symbol, :all, Array<Symbol, OpenAI::Models::Admin::Organization::Projects::ProjectOptionalServiceTier>]
            #     Additional service tiers enabled for this project. "all" includes future tiers.
            #     An empty array allows only Standard. Organization policy and eligibility still
            #     apply.
            #
            #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

            # Default tier for requests that omit service_tier or use auto.
            module Default
              extend OpenAI::Internal::Type::Enum

              STANDARD = :standard
              FAST = :fast
              SCALE = :scale

              # @!method self.values
              #   @return [Array<Symbol>]
            end

            # Additional service tiers enabled for this project. "all" includes future tiers.
            # An empty array allows only Standard. Organization policy and eligibility still
            # apply.
            module EnabledTiers
              extend OpenAI::Internal::Type::Union

              variant const: :all

              variant(
                -> {
                  OpenAI::Models::Admin::Organization::Projects::ServiceTierSettingUpdateParams::EnabledTiers::ProjectOptionalServiceTierArray
                }
              )

              # @!method self.variants
              #   @return [Array(Symbol, :all, Array<Symbol, OpenAI::Models::Admin::Organization::Projects::ProjectOptionalServiceTier>)]

              # @type [OpenAI::Internal::Type::Converter]
              ProjectOptionalServiceTierArray = OpenAI::Internal::Type::ArrayOf[
                enum: -> { OpenAI::Models::Admin::Organization::Projects::ProjectOptionalServiceTier }
              ]
            end
          end
        end
      end
    end
  end
end
