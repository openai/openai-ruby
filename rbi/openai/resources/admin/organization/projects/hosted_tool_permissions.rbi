# typed: strong

module OpenAI
  module Resources
    class Admin
      class Organization
        class Projects
          class HostedToolPermissions
            # Returns hosted tool permissions for a project.
            sig do
              params(
                project_id: String,
                request_options: OpenAI::RequestOptions::OrHash
              ).returns(
                OpenAI::Admin::Organization::Projects::ProjectHostedToolPermissions
              )
            end
            def retrieve(
              # The ID of the project.
              project_id,
              request_options: {}
            )
            end

            # Updates hosted tool permissions for a project.
            sig do
              params(
                project_id: String,
                code_interpreter:
                  T.nilable(
                    OpenAI::Admin::Organization::Projects::HostedToolPermissionUpdateParams::CodeInterpreter::OrHash
                  ),
                file_search:
                  T.nilable(
                    OpenAI::Admin::Organization::Projects::HostedToolPermissionUpdateParams::FileSearch::OrHash
                  ),
                image_generation:
                  T.nilable(
                    OpenAI::Admin::Organization::Projects::HostedToolPermissionUpdateParams::ImageGeneration::OrHash
                  ),
                mcp:
                  T.nilable(
                    OpenAI::Admin::Organization::Projects::HostedToolPermissionUpdateParams::Mcp::OrHash
                  ),
                web_search:
                  T.nilable(
                    OpenAI::Admin::Organization::Projects::HostedToolPermissionUpdateParams::WebSearch::OrHash
                  ),
                request_options: OpenAI::RequestOptions::OrHash
              ).returns(
                OpenAI::Admin::Organization::Projects::ProjectHostedToolPermissions
              )
            end
            def update(
              # The ID of the project.
              project_id,
              # The code interpreter permission update.
              code_interpreter: nil,
              # The file search permission update.
              file_search: nil,
              # The image generation permission update.
              image_generation: nil,
              # The MCP permission update.
              mcp: nil,
              # The web search permission update.
              web_search: nil,
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
