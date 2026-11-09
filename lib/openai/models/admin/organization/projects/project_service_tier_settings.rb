# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        module Projects
          # @see OpenAI::Resources::Admin::Organization::Projects::ServiceTierSettings#retrieve
          class ProjectServiceTierSettings < OpenAI::Internal::Type::BaseModel
            # @!attribute default
            #   Default tier for requests that omit service_tier or use auto.
            #
            #   @return [Symbol, OpenAI::Models::Admin::Organization::Projects::ProjectServiceTierSettings::Default]
            required :default, enum: -> { OpenAI::Admin::Organization::Projects::ProjectServiceTierSettings::Default }

            # @!attribute enabled_tiers
            #   Additional service tiers enabled for this project. "all" includes future tiers.
            #   An empty array allows only Standard. Organization policy and eligibility still
            #   apply.
            #
            #   @return [Symbol, :all, Array<Symbol, OpenAI::Models::Admin::Organization::Projects::ProjectOptionalServiceTier>]
            required(
              :enabled_tiers,
              union: -> { OpenAI::Admin::Organization::Projects::ProjectServiceTierSettings::EnabledTiers }
            )

            # @!attribute object
            #
            #   @return [Symbol, :"project.service_tier_settings"]
            required :object, const: :"project.service_tier_settings"

            # @!method initialize(default:, enabled_tiers:, object: :"project.service_tier_settings")
            #   @param default [Symbol, OpenAI::Models::Admin::Organization::Projects::ProjectServiceTierSettings::Default]
            #     Default tier for requests that omit service_tier or use auto.
            #
            #   @param enabled_tiers [Symbol, :all, Array<Symbol, OpenAI::Models::Admin::Organization::Projects::ProjectOptionalServiceTier>]
            #     Additional service tiers enabled for this project. "all" includes future tiers.
            #     An empty array allows only Standard. Organization policy and eligibility still
            #     apply.
            #
            #   @param object [Symbol, :"project.service_tier_settings"]

            # Default tier for requests that omit service_tier or use auto.
            #
            # @see OpenAI::Models::Admin::Organization::Projects::ProjectServiceTierSettings#default
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
            #
            # @see OpenAI::Models::Admin::Organization::Projects::ProjectServiceTierSettings#enabled_tiers
            module EnabledTiers
              extend OpenAI::Internal::Type::Union

              variant const: :all

              variant(
                -> {
                  OpenAI::Models::Admin::Organization::Projects::ProjectServiceTierSettings::EnabledTiers::ProjectOptionalServiceTierArray
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

        ProjectServiceTierSettings = Projects::ProjectServiceTierSettings
      end
    end
  end
end
