# typed: strong

module OpenAI
  module Resources

    class Beta

      class Agents

        class Automations

          sig { returns(OpenAI::Resources::Beta::Agents::Automations::Invocations) }
          attr_reader :invocations

          # Saves an active automation without invoking it immediately.
          sig {
            params(
              create_automation_params: T.any(
                OpenAI::Beta::Agents::AutomationScheduleParam::Periodic::OrHash,
                OpenAI::Beta::Agents::AutomationScheduleParam::Once::OrHash
              ),
              request_options: OpenAI::RequestOptions::OrHash
            )
              .returns(OpenAI::Beta::Agents::Automation::Variants)
          }
          def create(
            # Creates an automation without invoking it immediately.
            create_automation_params:,
            request_options: {}
          )
          end

          # Retrieves a project-owned automation.
          sig {
            params(automation_id: String, request_options: OpenAI::RequestOptions::OrHash).returns(
              OpenAI::Beta::Agents::Automation::Variants
            )
          }
          def retrieve(automation_id, request_options: {})
          end

          # Updates supplied fields; target and metadata replace the whole field.
          sig {
            params(
              automation_id: String,
              expression: String,
              metadata: T::Hash[Symbol, String],
              name: String,
              run_at: Integer,
              target: T.any(
                OpenAI::Beta::Agents::AutomationTargetParam::NewSession::OrHash,
                OpenAI::Beta::Agents::AutomationTargetParam::ExistingSession::OrHash
              ),
              timezone: String,
              request_options: OpenAI::RequestOptions::OrHash
            )
              .returns(OpenAI::Beta::Agents::Automation::Variants)
          }
          def update(
            automation_id,
            # Only accepted for periodic automations.
            expression: nil,
            # Replaces all metadata; omit to leave unchanged.
            metadata: nil,
            name: nil,
            # A future Unix timestamp in seconds; accepted only before a one-time scheduled
            # invocation exists.
            run_at: nil,
            # Replaces the complete target, retaining its type and any creator session.
            target: nil,
            # Only accepted for periodic automations.
            timezone: nil,
            request_options: {}
          )
          end

          # Lists project-owned automations, optionally filtered by target session.
          sig {
            params(
              after: String,
              limit: Integer,
              order: OpenAI::Beta::Agents::AutomationListParams::Order::OrSymbol,
              session_id: String,
              request_options: OpenAI::RequestOptions::OrHash
            )
              .returns(OpenAI::Internal::CursorPage[OpenAI::Beta::Agents::Automation::Variants])
          }
          def list(
            # Return resources after this resource ID in the selected order.
            after: nil,
            # The maximum number of resources to return, between 1 and 100. Defaults to 20.
            limit: nil,
            # The order in which resources are returned. Defaults to `desc`.
            order: nil,
            # Matches existing-session targets, including agent-created automations.
            session_id: nil,
            request_options: {}
          )
          end

          # Deletes the automation and prevents future invocations without deleting its
          # target session.
          sig {
            params(automation_id: String, request_options: OpenAI::RequestOptions::OrHash).returns(
              OpenAI::Beta::Agents::AutomationDeleted
            )
          }
          def delete(automation_id, request_options: {})
          end

          # Pauses future scheduled delivery without stopping an active session.
          sig {
            params(automation_id: String, request_options: OpenAI::RequestOptions::OrHash).returns(
              OpenAI::Beta::Agents::Automation::Variants
            )
          }
          def pause(automation_id, request_options: {})
          end

          # Resumes scheduled delivery; one-time automations without a pending invocation
          # require a future run_at.
          sig {
            params(automation_id: String, request_options: OpenAI::RequestOptions::OrHash).returns(
              OpenAI::Beta::Agents::Automation::Variants
            )
          }
          def resume(automation_id, request_options: {})
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
