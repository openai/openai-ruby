# typed: strong

module OpenAI
  module Resources
    class Admin
      class Organization
        class Projects
          class DataRetention
            # Retrieves project data retention controls.
            sig do
              params(
                project_id: String,
                request_options: OpenAI::RequestOptions::OrHash
              ).returns(
                OpenAI::Admin::Organization::Projects::ProjectDataRetention
              )
            end
            def retrieve(
              # The ID of the project to inspect.
              project_id,
              request_options: {}
            )
            end

            # Updates project data retention controls.
            sig do
              params(
                project_id: String,
                retention_type:
                  OpenAI::Admin::Organization::Projects::DataRetentionUpdateParams::RetentionType::OrSymbol,
                request_options: OpenAI::RequestOptions::OrHash
              ).returns(
                OpenAI::Admin::Organization::Projects::ProjectDataRetention
              )
            end
            def update(
              # The ID of the project to update.
              project_id,
              # The desired project data retention type.
              retention_type:,
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
