# typed: strong

module OpenAI
  module Resources

    class Beta

      class Agents

        class Sessions

          class Subagents

            sig { returns(OpenAI::Resources::Beta::Agents::Sessions::Subagents::Items) }
            attr_reader :items

            sig { returns(OpenAI::Resources::Beta::Agents::Sessions::Subagents::Turns) }
            attr_reader :turns

            # Retrieves a subagent belonging to this session. See
            # [subagent workflows](https://developers.openai.com/api/docs/guides/agents-api/multi-agent).
            sig {
              params(subagent_id: String, session_id: String, request_options: OpenAI::RequestOptions::OrHash).returns(
                OpenAI::Beta::Subagent
              )
            }
            def retrieve(
              # The ID of the subagent in this session.
              subagent_id,
              # The ID of the session.
              session_id:,
              request_options: {}
            )
            end

            # Lists subagents in a session, including nested and closed subagents. See
            # [subagent workflows](https://developers.openai.com/api/docs/guides/agents-api/multi-agent).
            sig {
              params(
                session_id: String,
                after: String,
                limit: Integer,
                order: OpenAI::Beta::Agents::Sessions::SubagentListParams::Order::OrSymbol,
                request_options: OpenAI::RequestOptions::OrHash
              )
                .returns(OpenAI::Internal::CursorPage[OpenAI::Beta::Subagent])
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
