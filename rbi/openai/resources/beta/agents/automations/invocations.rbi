# typed: strong

module OpenAI
  module Resources

    class Beta

      class Agents

        class Automations

          class Invocations

            # Queues a manual delivery without changing the saved schedule.
            sig {
              params(automation_id: String, request_options: OpenAI::RequestOptions::OrHash).returns(
                OpenAI::Beta::Agents::Automations::AutomationInvocation
              )
            }
            def create(automation_id, request_options: {})
            end

            # Retrieves a delivery record for a project-owned automation.
            sig {
              params(invocation_id: String, automation_id: String, request_options: OpenAI::RequestOptions::OrHash)
                .returns(OpenAI::Beta::Agents::Automations::AutomationInvocation)
            }
            def retrieve(invocation_id, automation_id:, request_options: {})
            end

            # Lists delivery records for a project-owned automation.
            sig {
              params(
                automation_id: String,
                after: String,
                limit: Integer,
                order: OpenAI::Beta::Agents::Automations::InvocationListParams::Order::OrSymbol,
                request_options: OpenAI::RequestOptions::OrHash
              )
                .returns(OpenAI::Internal::CursorPage[OpenAI::Beta::Agents::Automations::AutomationInvocation])
            }
            def list(
              automation_id,
              # Return resources after this resource ID in the selected order.
              after: nil,
              # The maximum number of resources to return, between 1 and 100. Defaults to 20.
              limit: nil,
              # The order in which resources are returned. Defaults to `desc`.
              order: nil,
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
