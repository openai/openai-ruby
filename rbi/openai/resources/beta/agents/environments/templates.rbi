# typed: strong

module OpenAI
  module Resources

    class Beta

      class Agents

        class Environments

          class Templates

            # Creates reusable environment configuration without returning confidential setup
            # commands or environment values. See
            # [reusing a hosted setup](https://developers.openai.com/api/docs/guides/agents-api/tools#reuse-a-hosted-plugin-setup).
            sig {
              params(
                capability_directories: T.nilable(T::Array[String]),
                env: T.nilable(T::Hash[Symbol, String]),
                files: T.nilable(
                  T::Array[
                    T.any(
                      OpenAI::Beta::HostedEnvironmentFileParam::FileID::OrHash,
                      OpenAI::Beta::HostedEnvironmentFileParam::Inline::OrHash
                    )
                  ]
                ),
                name: T.nilable(String),
                network: T.nilable(OpenAI::Beta::Agents::Environments::TemplateCreateParams::Network::OrHash),
                packages: T.nilable(OpenAI::Beta::Agents::Environments::TemplateCreateParams::Packages::OrHash),
                plugins: T.nilable(T::Array[OpenAI::Beta::HostedPluginParam::OrHash]),
                setup_commands: T.nilable(T::Array[OpenAI::Beta::SetupCommandParam::OrHash]),
                skills: T.nilable(
                  T::Array[
                    T.any(
                      OpenAI::Beta::HostedSkillParam::SkillReference::OrHash,
                      OpenAI::Beta::HostedSkillParam::Inline::OrHash
                    )
                  ]
                ),
                request_options: OpenAI::RequestOptions::OrHash
              )
                .returns(OpenAI::Beta::Agents::Environments::EnvironmentTemplate)
            }
            def create(
              # Directories that contain capabilities exposed to the agent. Defaults to an empty
              # list.
              capability_directories: nil,
              # Environment variables made available to the agent.
              env: nil,
              # Files available before the agent starts. Defaults to an empty list.
              files: nil,
              # An optional human-readable display name for the template.
              name: nil,
              # Network access for an OpenAI-hosted environment.
              network: nil,
              # Packages to install in an OpenAI-hosted environment.
              packages: nil,
              # Plugins provided as inline ZIP archives. Defaults to an empty list.
              plugins: nil,
              # Ordered, confidential setup commands. Command bodies are never returned.
              setup_commands: nil,
              # Skills referenced by ID or provided as inline ZIP archives. Defaults to an empty
              # list.
              skills: nil,
              request_options: {}
            )
            end

            # Retrieves reusable environment configuration without returning confidential
            # values. See
            # [reusing a hosted setup](https://developers.openai.com/api/docs/guides/agents-api/tools#reuse-a-hosted-plugin-setup).
            sig {
              params(environment_template_id: String, request_options: OpenAI::RequestOptions::OrHash).returns(
                OpenAI::Beta::Agents::Environments::EnvironmentTemplate
              )
            }
            def retrieve(
              # The ID of the reusable environment template.
              environment_template_id,
              request_options: {}
            )
            end

            # Updates reusable environment configuration without returning confidential
            # values. See
            # [reusing a hosted setup](https://developers.openai.com/api/docs/guides/agents-api/tools#reuse-a-hosted-plugin-setup).
            sig {
              params(
                environment_template_id: String,
                capability_directories: T.nilable(T::Array[String]),
                env: T.nilable(T::Hash[Symbol, String]),
                files: T.nilable(
                  T::Array[
                    T.any(
                      OpenAI::Beta::HostedEnvironmentFileParam::FileID::OrHash,
                      OpenAI::Beta::HostedEnvironmentFileParam::Inline::OrHash
                    )
                  ]
                ),
                name: T.nilable(String),
                network: T.nilable(OpenAI::Beta::Agents::Environments::TemplateUpdateParams::Network::OrHash),
                packages: T.nilable(OpenAI::Beta::Agents::Environments::TemplateUpdateParams::Packages::OrHash),
                plugins: T.nilable(T::Array[OpenAI::Beta::HostedPluginParam::OrHash]),
                setup_commands: T.nilable(T::Array[OpenAI::Beta::SetupCommandParam::OrHash]),
                skills: T.nilable(
                  T::Array[
                    T.any(
                      OpenAI::Beta::HostedSkillParam::SkillReference::OrHash,
                      OpenAI::Beta::HostedSkillParam::Inline::OrHash
                    )
                  ]
                ),
                request_options: OpenAI::RequestOptions::OrHash
              )
                .returns(OpenAI::Beta::Agents::Environments::EnvironmentTemplate)
            }
            def update(
              # The ID of the reusable environment template.
              environment_template_id,
              # Directories that expose capabilities to the agent.
              capability_directories: nil,
              # Replacement confidential environment values.
              env: nil,
              # Replacement file configuration materialized for each new session.
              files: nil,
              # A replacement human-readable display name, or `null` to clear the name.
              name: nil,
              # Network access for an OpenAI-hosted environment.
              network: nil,
              # Packages to install in an OpenAI-hosted environment.
              packages: nil,
              # Replacement plugin configuration installed for each new session.
              plugins: nil,
              # Replacement confidential setup commands, never included in returned resources.
              setup_commands: nil,
              # Replacement skill configuration installed for each new session.
              skills: nil,
              request_options: {}
            )
            end

            # Lists reusable environment templates without returning confidential values. See
            # [reusing a hosted setup](https://developers.openai.com/api/docs/guides/agents-api/tools#reuse-a-hosted-plugin-setup).
            sig {
              params(
                after: String,
                limit: Integer,
                order: OpenAI::Beta::Agents::Environments::TemplateListParams::Order::OrSymbol,
                request_options: OpenAI::RequestOptions::OrHash
              )
                .returns(OpenAI::Internal::CursorPage[OpenAI::Beta::Agents::Environments::EnvironmentTemplate])
            }
            def list(
              # Return resources after this resource ID in the selected order.
              after: nil,
              # The maximum number of resources to return, between 1 and 100. Defaults to 20.
              limit: nil,
              # The order in which resources are returned. Defaults to `desc`.
              order: nil,
              request_options: {}
            )
            end

            # Deletes reusable environment configuration and all confidential template inputs.
            # See
            # [reusing a hosted setup](https://developers.openai.com/api/docs/guides/agents-api/tools#reuse-a-hosted-plugin-setup).
            sig {
              params(environment_template_id: String, request_options: OpenAI::RequestOptions::OrHash).returns(
                OpenAI::Beta::Agents::Environments::EnvironmentTemplateDeleted
              )
            }
            def delete(
              # The ID of the reusable environment template.
              environment_template_id,
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
