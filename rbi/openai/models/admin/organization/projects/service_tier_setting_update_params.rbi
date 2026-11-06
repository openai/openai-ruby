# typed: strong

module OpenAI
  module Models

    module Admin

      module Organization

        module Projects

          class ServiceTierSettingUpdateParams < OpenAI::Internal::Type::BaseModel

            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            OrHash = T.type_alias do
              T.any(
                OpenAI::Admin::Organization::Projects::ServiceTierSettingUpdateParams,
                OpenAI::Internal::AnyHash
              )
            end

            # The ID of the project
            sig { returns(String) }
            attr_accessor :project_id

            # Default tier for requests that omit service_tier or use auto.
            sig {
              returns(
                T.nilable(OpenAI::Admin::Organization::Projects::ServiceTierSettingUpdateParams::Default::OrSymbol)
              )
            }
            attr_reader :default

            sig {
              params(default: OpenAI::Admin::Organization::Projects::ServiceTierSettingUpdateParams::Default::OrSymbol)
                .void
            }
            attr_writer :default

            # Additional service tiers enabled for this project. "all" includes future tiers.
            # An empty array allows only Standard. Organization policy and eligibility still
            # apply.
            sig {
              returns(
                T.nilable(
                  T.any(Symbol, T::Array[OpenAI::Admin::Organization::Projects::ProjectOptionalServiceTier::OrSymbol])
                )
              )
            }
            attr_reader :enabled_tiers

            sig {
              params(
                enabled_tiers: T.any(
                  Symbol,
                  T::Array[OpenAI::Admin::Organization::Projects::ProjectOptionalServiceTier::OrSymbol]
                )
              )
                .void
            }
            attr_writer :enabled_tiers

            sig do
              params(

                project_id: String,

                default: OpenAI::Admin::Organization::Projects::ServiceTierSettingUpdateParams::Default::OrSymbol,

                enabled_tiers: T.any(
                  Symbol,
                  T::Array[OpenAI::Admin::Organization::Projects::ProjectOptionalServiceTier::OrSymbol]
                ),

                request_options: OpenAI::RequestOptions::OrHash
              )
                .returns(T.attached_class)
            end
            def self.new(

              # The ID of the project
              project_id:,

              # Default tier for requests that omit service_tier or use auto.
              default: nil,

              # Additional service tiers enabled for this project. "all" includes future tiers.
              # An empty array allows only Standard. Organization policy and eligibility still
              # apply.
              enabled_tiers: nil,

              request_options: {}
            )
            end

            sig do
              override.returns(
                {
                  project_id: String,
                  default: OpenAI::Admin::Organization::Projects::ServiceTierSettingUpdateParams::Default::OrSymbol,
                  enabled_tiers: T.any(
                    Symbol,
                    T::Array[OpenAI::Admin::Organization::Projects::ProjectOptionalServiceTier::OrSymbol]
                  ),
                  request_options: OpenAI::RequestOptions
                }
              )
            end
            def to_hash
            end

            # Default tier for requests that omit service_tier or use auto.
            module Default
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol = T.type_alias {
                T.all(Symbol, OpenAI::Admin::Organization::Projects::ServiceTierSettingUpdateParams::Default)
              }
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              STANDARD = T.let(
                :standard,
                OpenAI::Admin::Organization::Projects::ServiceTierSettingUpdateParams::Default::TaggedSymbol
              )
              FAST = T.let(
                :fast,
                OpenAI::Admin::Organization::Projects::ServiceTierSettingUpdateParams::Default::TaggedSymbol
              )
              SCALE = T.let(
                :scale,
                OpenAI::Admin::Organization::Projects::ServiceTierSettingUpdateParams::Default::TaggedSymbol
              )

              sig {
                override.returns(
                  T::Array[OpenAI::Admin::Organization::Projects::ServiceTierSettingUpdateParams::Default::TaggedSymbol]
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
                  T::Array[
                    OpenAI::Admin::Organization::Projects::ServiceTierSettingUpdateParams::EnabledTiers::Variants
                  ]
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
