# typed: strong

module OpenAI
  module Resources

    class Beta

      class Agents

        class Sessions

          class Items

            # Lists items produced by the session's root agent, including its interactions
            # with subagents. Each subagent has its own item history. See
            # [inspecting agent output](https://developers.openai.com/api/docs/guides/agents-api/observability).
            sig {
              params(
                session_id: String,
                after: String,
                limit: Integer,
                order: OpenAI::Beta::Agents::Sessions::ItemListParams::Order::OrSymbol,
                request_options: OpenAI::RequestOptions::OrHash
              )
                .returns(OpenAI::Internal::CursorPage[OpenAI::Beta::AgentSessionItem::Variants])
            }
            def list(
              # The ID of the session.
              session_id,
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
