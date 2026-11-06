# typed: strong

module OpenAI
  module Resources

    class Admin

      class Organization

        class Projects

          class ServiceTierSettings

            # Retrieve the configured default and enabled service tiers for a project.
            sig {
              params(project_id: String, request_options: OpenAI::RequestOptions::OrHash).returns(
                OpenAI::Admin::Organization::Projects::ProjectServiceTierSettings
              )
            }
            def retrieve(
              # The ID of the project
              project_id,
              request_options: {}
            )
            end

            # Update the default or enabled service tiers atomically. Supply at least one
            # field. Omitted fields keep their current values.
            sig {
              params(
                project_id: String,
                default: OpenAI::Admin::Organization::Projects::ServiceTierSettingUpdateParams::Default::OrSymbol,
                enabled_tiers: T.any(
                  Symbol,
                  T::Array[OpenAI::Admin::Organization::Projects::ProjectOptionalServiceTier::OrSymbol]
                ),
                request_options: OpenAI::RequestOptions::OrHash
              )
                .returns(OpenAI::Admin::Organization::Projects::ProjectServiceTierSettings)
            }
            def update(
              # The ID of the project
              project_id,
              # Default tier for requests that omit service_tier or use auto.
              default: nil,
              # Additional service tiers enabled for this project. "all" includes future tiers.
              # An empty array allows only Standard. Organization policy and eligibility still
              # apply.
              enabled_tiers: nil,
              request_options: {}
            )
            end

            # @api private
            sig { params(client: OpenAI::Client).returns(T.attached_class) }
            def self.new(client:)
            end
          end

        end

      end

    end

  end
end
