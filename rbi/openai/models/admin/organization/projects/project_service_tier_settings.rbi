# typed: strong

module OpenAI
  module Models

    module Admin

      module Organization

        ProjectServiceTierSettings = Projects::ProjectServiceTierSettings

        module Projects

          class ProjectServiceTierSettings < OpenAI::Internal::Type::BaseModel

            OrHash = T.type_alias do
              T.any(
                OpenAI::Admin::Organization::Projects::ProjectServiceTierSettings,
                OpenAI::Internal::AnyHash
              )
            end

            # Default tier for requests that omit service_tier or use auto.
            sig { returns(OpenAI::Admin::Organization::Projects::ProjectServiceTierSettings::Default::TaggedSymbol) }
            attr_accessor :default

            # Additional service tiers enabled for this project. "all" includes future tiers.
            # An empty array allows only Standard. Organization policy and eligibility still
            # apply.
            sig { returns(OpenAI::Admin::Organization::Projects::ProjectServiceTierSettings::EnabledTiers::Variants) }
            attr_accessor :enabled_tiers

            sig { returns(Symbol) }
            attr_accessor :object

            sig do
              params(

                default: OpenAI::Admin::Organization::Projects::ProjectServiceTierSettings::Default::OrSymbol,

                enabled_tiers: T.any(
                  Symbol,
                  T::Array[OpenAI::Admin::Organization::Projects::ProjectOptionalServiceTier::OrSymbol]
                ),

                object: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(

              # Default tier for requests that omit service_tier or use auto.
              default:,

              # Additional service tiers enabled for this project. "all" includes future tiers.
              # An empty array allows only Standard. Organization policy and eligibility still
              # apply.
              enabled_tiers:,

              object: :"project.service_tier_settings"
            )
            end

            sig do
              override.returns(
                {
                  default: OpenAI::Admin::Organization::Projects::ProjectServiceTierSettings::Default::TaggedSymbol,
                  enabled_tiers: OpenAI::Admin::Organization::Projects::ProjectServiceTierSettings::EnabledTiers::Variants,
                  object: Symbol
                }
              )
            end
            def to_hash
            end

            # Default tier for requests that omit service_tier or use auto.
            module Default
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol = T.type_alias {
                T.all(Symbol, OpenAI::Admin::Organization::Projects::ProjectServiceTierSettings::Default)
              }
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              STANDARD = T.let(
                :standard,
                OpenAI::Admin::Organization::Projects::ProjectServiceTierSettings::Default::TaggedSymbol
              )
              FAST = T.let(
                :fast,
                OpenAI::Admin::Organization::Projects::ProjectServiceTierSettings::Default::TaggedSymbol
              )
              SCALE = T.let(
                :scale,
                OpenAI::Admin::Organization::Projects::ProjectServiceTierSettings::Default::TaggedSymbol
              )

              sig {
                override.returns(
                  T::Array[OpenAI::Admin::Organization::Projects::ProjectServiceTierSettings::Default::TaggedSymbol]
                )
              }
              def self.values
              end
            end

            # Additional service tiers enabled for this project. "all" includes future tiers.
            # An empty array allows only Standard. Organization policy and eligibility still
            # apply.
            module EnabledTiers
              extend OpenAI::Internal::Type::Union

              Variants = T.type_alias {
                T.any(Symbol, T::Array[OpenAI::Admin::Organization::Projects::ProjectOptionalServiceTier::TaggedSymbol])
              }

              sig {
                override.returns(
                  T::Array[OpenAI::Admin::Organization::Projects::ProjectServiceTierSettings::EnabledTiers::Variants]
                )
              }
              def self.variants
              end

              ProjectOptionalServiceTierArray = T.let(
                OpenAI::Internal::Type::ArrayOf[
                  enum: -> { OpenAI::Models::Admin::Organization::Projects::ProjectOptionalServiceTier }
                ],
                OpenAI::Internal::Type::Converter
              )

            end

          end

        end

      end

    end

  end
end
